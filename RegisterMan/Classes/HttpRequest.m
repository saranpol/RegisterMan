//
//  HttpRequest.m
//  Molome
//
//  Created by Apple on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

- (id)init {
    self = [super init];
	// init some data
	currentDataLoad = 0;
	receivedData = [[NSMutableData alloc] initWithLength:0];
	
	
	done = NO;
	
    return self;
}


- (void)dealloc {
	[receivedData release];
	
	
	
    [super dealloc];
}







-(void)processResponse:(NSMutableData *)for_process_data {
	if(for_process_data)
		printf("result = %s\n", (char *)[for_process_data bytes]);
	else
		[mListener saveDataIniPad];

	[mListener receivedResponse];
	
	
}






// #################
//     Internet 
// #################

@synthesize receivedData;
@synthesize networkingCount = _networkingCount;
@synthesize connection    = _connection;



- (void)_receiveDidStopWithStatus:(NSString *)statusString {
	NSMutableData *for_process_data;
    if (statusString == nil) {
		printf("Get succeeded yeah %s\n", [statusString UTF8String]);
		printf("receivedData Length= %i\n", [receivedData length]);
		//[self initBuffer];
		//printf("result = %s\n", buffer);
		for_process_data = [receivedData copy];
		//[receivedData release];
    }else {
		printf("statusString = %s\n", [statusString UTF8String]);
	}
	//[self.activityIndicator stopAnimating];
	[self finishProgress];
	[self didStopNetworking];
	
	if (statusString == nil) {
		// receive
		[self processResponse:for_process_data];
		[for_process_data release];
	}else{
		// fail
		[self processResponse:nil];
	}

	// check image upload queue
	//[self processShareImageArray];
	done = YES;
}

- (void)_receiveDidStart
{
    //[self.activityIndicator startAnimating];
	[self didStartNetworking];
}

#pragma mark Call Server

- (void)cancel_connect {
	if(self.connection != nil){
		[self.connection cancel];
		self.connection = nil;
		[self didStopNetworking];
		done = YES;
	}
}



- (void)_stopReceiveWithStatus:(NSString *)statusString {
    if (self.connection != nil) {
        [self.connection cancel];
        self.connection = nil;
    }
    [self _receiveDidStopWithStatus:statusString];
}


# pragma mark Network Main

- (void)didStartNetworking {
    self.networkingCount += 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didStopNetworking {
    assert(self.networkingCount > 0);
    self.networkingCount -= 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = (self.networkingCount != 0);
}

- (void)finishProgress {
	//[[MolomeAppDelegate service] hideViewLoading];
}

#pragma mark Core transfer code


- (BOOL)isReceiving {
    return (self.connection != nil);
}


- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response {
#pragma unused(theConnection)
	
	[self.receivedData setLength:0];
	
	
    NSHTTPURLResponse * httpResponse;
    //NSString *          contentTypeHeader;
	
    assert(theConnection == self.connection);
    
    httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
	printf("status code = %i\n", httpResponse.statusCode);
	
	/* receive data whatever
	 if ((httpResponse.statusCode / 100) != 2) {
	 [self _stopReceiveWithStatus:[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]];
	 } else {
	 contentTypeHeader = [httpResponse.allHeaderFields objectForKey:@"Content-Type"];
	 if (contentTypeHeader == nil) {
	 [self _stopReceiveWithStatus:@"No Content-Type!"];
	 } else {
	 NSString *contentLength = [httpResponse.allHeaderFields objectForKey:@"Content-Length"];
	 printf("response ok Content-Length=%s\n", [contentLength UTF8String]);
	 }
	 }
	 */
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data {
#pragma unused(theConnection)
    NSInteger       dataLength;
    const uint8_t * dataBytes;
	
    assert(theConnection == self.connection);
    
    dataLength = [data length];
    dataBytes  = [data bytes];
	
	currentDataLoad += dataLength;
	printf("current %d\n", currentDataLoad);
	
	[self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register" 
													message:@"Please connect to internet\nSaved data in iPad."
												   delegate:nil 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles: nil];
	[alert show];
	[alert release];
	
#pragma unused(theConnection)
#pragma unused(error)
    assert(theConnection == self.connection);
    
    [self _stopReceiveWithStatus:@"Connection failed"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection {
#pragma unused(theConnection)
    assert(theConnection == self.connection);
    
    [self _stopReceiveWithStatus:nil];
}




























@end
