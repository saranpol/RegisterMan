//
//  HttpRequest.h
//  Molome
//
//  Created by Apple on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpRequest : NSObject {

@public	
	// Internet
	NSMutableData *receivedData;
	char *buffer;
	int length;
	NSInteger _networkingCount;
	NSURLConnection *_connection;
	NSInteger currentDataLoad;
	NSInteger totalDataLoad;
	//int mApiMode;
	
	
	BOOL done;
	id mListener;
}

// Internet
- (void)didStartNetworking;
- (void)didStopNetworking;
- (void)cancel_connect;
- (void)finishProgress;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, assign) NSInteger networkingCount;
@property (nonatomic, readonly) BOOL isReceiving;
@property (nonatomic, retain)   NSURLConnection *connection;

- (void)_receiveDidStart;


@end
