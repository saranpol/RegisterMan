//
//  RegisterManViewController.m
//  RegisterMan
//
//  Created by saranpol on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegisterManViewController.h"
#import "HttpRequest.h"
#import "ViewSetting.h"

@implementation RegisterManViewController

@synthesize mUserImage;
@synthesize mUsernameTextField;
@synthesize mPhoneTextField;
@synthesize mEmailTextField;
@synthesize mActivityLoading;
@synthesize mInputView;
@synthesize mThankYouView;
@synthesize mHomeButton;
@synthesize mSendButton;
@synthesize mResetButton;
@synthesize mTakePhotoButton;


// File Manager
@synthesize dataPath;
@synthesize filePath;


















// ################
// File Management
// ################

#pragma mark -
#pragma mark File Management


void AlertWithError(NSError *error)
{
    printf("Error! %s %s", [[error localizedDescription] UTF8String], [[error localizedFailureReason] UTF8String]);
	
}

/*
 - (void) saveFile:(NSString *)fileName data:(char *)buf size:(NSInteger)size{
 
 //NSData *tmpData = [NSData dataWithBytesNoCopy:(void *)buf length:size];
 NSData *tmpData = [NSData dataWithBytes:(void *)buf length:size];
 
 [filePath release]; //release previous instance
 filePath = [[dataPath stringByAppendingPathComponent:fileName] retain];
 
 //if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO)
 
 printf("write %s\n", [filePath UTF8String]);
 [[NSFileManager defaultManager] createFileAtPath:filePath
 contents:tmpData
 attributes:nil];
 }
 */
- (void)saveFile:(NSString *)fileName data:(NSData *)tmpData{
	
	[filePath release]; //release previous instance
	filePath = [[dataPath stringByAppendingPathComponent:fileName] retain];
	
	printf("write %s\n", [filePath UTF8String]);
	[[NSFileManager defaultManager] createFileAtPath:filePath
											contents:tmpData
										  attributes:nil];
}


- (void) deleteFile:(NSString *)fileName{
	NSString *fName = [dataPath stringByAppendingPathComponent:fileName];
	if ([[NSFileManager defaultManager] fileExistsAtPath:fName]) {
		if (![[NSFileManager defaultManager] removeItemAtPath:fName error:&mError])
			AlertWithError(mError);
	}
}

- (void) deleteFileFormat:(NSString *)formatName{
	//NSArray *dirContents = [[NSFileManager defaultManager] directoryContentsAtPath:dataPath];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	for (NSString *file in dirContents) {
		if ([[file pathExtension] isEqualToString:formatName]) {
			[self deleteFile:file];
		}
	}
}

- (int) countFileFormat:(NSString *)formatName{
	//NSArray *dirContents = [[NSFileManager defaultManager] directoryContentsAtPath:dataPath];
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	int count = 0;
	for (NSString *file in dirContents) {
		if ([[file pathExtension] isEqualToString:formatName]) {
			count++;
		}
	}
	return count;
}

- (void) setupDirectory
{
	/* create path to cache directory inside the application's Documents
	 directory */
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	self.dataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"cache"];
	printf("dataPath = %s\n", [self.dataPath UTF8String]);
	
	/* check for existence of cache directory */
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&mError]) {
		AlertWithError(mError);
		return;
	}
}

/* removes every file in the directory */

- (void) clearDirectory
{
	/* remove the cache directory and its contents */
	if (![[NSFileManager defaultManager] removeItemAtPath:dataPath error:&mError]) {
		AlertWithError(mError);
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:&mError]) {
		AlertWithError(mError);
		return;
	}
	
}

//#define TIME_CACHE 86400.0 // one day
#define TIME_CACHE 10.0

- (BOOL)is_old_file:(NSString *)fName
{
	NSDictionary* properties = [[NSFileManager defaultManager]
								attributesOfItemAtPath:fName
								error:&mError];
	if(!properties)
		return YES;
	
	NSDate* modDate = [properties objectForKey:NSFileModificationDate];
	
	//printf("\n\n\nxxxxx %s\n", [[modDate description] UTF8String]);
	//printf("file time %f \n", [modDate timeIntervalSinceNow]);
	
	if(fabs([modDate timeIntervalSinceNow]) > TIME_CACHE)
		return YES;
	else
		return NO;
}

//#define KFileCardNearMeList @"list.nml"
- (void)ClearCache
{
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&mError];
	for (NSString *file in dirContents) {
		//if([self is_old_file:file]){
		[self deleteFile:file];
		printf("will delete file cache = %s\n", [file UTF8String]);
		//}
	}
}


- (BOOL)isFileExist:(NSString *)fName
{
	fName = [dataPath stringByAppendingPathComponent:fName];
	return [[NSFileManager defaultManager] fileExistsAtPath:fName];
}



- (NSData*)contentOfFile:(NSString *)fName
{
	fName = [dataPath stringByAppendingPathComponent:fName];
	return [NSData dataWithContentsOfFile:fName];
}























// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// File manager
	[self setupDirectory];
	
	


	
	
	
	mImagePicker = [[UIImagePickerController alloc] init];
	
	//[mImagePicker setAllowsEditing:YES];
	[mImagePicker setAllowsEditing:NO];
    [mImagePicker setDelegate:self];
	mFirstShow = YES;
	
	mViewSetting = [[ViewSetting alloc] initWithNibName:@"ViewSetting" bundle:nil];
	mViewSetting->mRegisterManViewController = self;
	[self.view addSubview:mViewSetting.view];
	[mViewSetting.view removeFromSuperview];
	
	
	// load from nsuser
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSArray *load_array = [prefs arrayForKey:@"mRegisterDataArray"];
	if(!load_array)
		mRegisterDataArray = [[NSMutableArray alloc] init];
	else {
		mRegisterDataArray = [[NSMutableArray alloc] initWithArray:load_array];
		[mViewSetting setupRegisterData:mRegisterDataArray];
		[mViewSetting->mTableView reloadData];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	if(mFirstShow){
		mViewHome = [[ViewHome alloc] initWithNibName:@"ViewHome" bundle:nil];
		[self presentModalViewController:mViewHome animated:NO];
		mFirstShow = NO;
	}
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mUserImage release];
	[mImagePicker release];
	[mViewHome release];
	if(mViewSetting)
		[mViewSetting release];
	[mInputView release];
	[mThankYouView release];
	[mHomeButton release];
	[mSendButton release];
	[mResetButton release];
	[mTakePhotoButton release];
	
	if (mPopoverController && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		[mPopoverController release];

	
	[mUsernameTextField release];
	[mPhoneTextField release];
	[mEmailTextField release];
	[mActivityLoading release];
	
	[mRegisterDataArray release];
	
    [super dealloc];
}


- (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient
{
	CGImageRef          imgRef = img.CGImage;
	CGFloat             width = CGImageGetWidth(imgRef);
	CGFloat             height = CGImageGetHeight(imgRef);
	CGAffineTransform   transform = CGAffineTransformIdentity;
	CGRect              bounds = CGRectMake(0, 0, width, height);
	CGSize              imageSize = bounds.size;
	CGFloat             boundHeight;
	
	switch(orient) {
			
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
			
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
			
		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;
			
		default:
			// image is not auto-rotated by the photo picker, so whatever the user
			// sees is what they expect to get. No modification necessary
			transform = CGAffineTransformIdentity;
			break;
			
	}
	
	UIGraphicsBeginImageContext(bounds.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if ((orient == UIImageOrientationDown) || (orient == UIImageOrientationRight) || (orient == UIImageOrientationUp)){
		// flip the coordinate space upside down
		CGContextScaleCTM(context, 1, -1);
		CGContextTranslateCTM(context, 0, -height);
	}
	
	CGContextConcatCTM(context, transform);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageCopy;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//UIImage *original_image =[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *original_image =[info objectForKey:UIImagePickerControllerOriginalImage];
	//[mUserImage setImage:original_image];
	[mUserImage setImage:[self rotateImage:original_image byOrientationFlag:original_image.imageOrientation]];
	[mImagePicker dismissModalViewControllerAnimated:YES];
	//[self clickSubmitButton:nil];
	mUserImage.hidden = NO;
	mInputView.hidden = YES;
	mSendButton.hidden = NO;
	mTakePhotoButton.hidden = YES;
	mResetButton.hidden = NO;
	mSendButton.enabled = YES;
}


- (IBAction)clickCameraButton:(id)sender {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[mImagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
		mImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		[self presentModalViewController:mImagePicker animated:YES];
    }else{
		[mImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			if(!mPopoverController)
				mPopoverController = [[UIPopoverController alloc] initWithContentViewController: mImagePicker];
			[mPopoverController presentPopoverFromRect:CGRectMake(0, 0, 1024, 768) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		}else 
			[self presentModalViewController:mImagePicker animated:YES];
	}
}

- (IBAction)clickLibraryButton:(id)sender {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		[mImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }else{
		return;
	}
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		[mPopoverController presentPopoverFromRect:CGRectMake(0, 0, 1024, 768) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	else
		[self presentModalViewController:mImagePicker animated:YES];
}



//[http_request release];
#define BOUNDARY @"----239048230sdAaB03x"


-(NSString*)arrayToMultipart:(NSMutableDictionary*)data boundary:(NSString*)boundary {
	NSString *str = @"";
	for(NSString* key in data) {
		NSString *value = [data objectForKey:key];
		str = [str stringByAppendingFormat:@"--%@\r\n", boundary];
		str = [str stringByAppendingFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
		str = [str stringByAppendingString:@"\r\n"];
		str = [str stringByAppendingFormat:@"%@\r\n", value];
	}
	return str;
}



- (NSMutableURLRequest*)create_request:(NSString*)url_string{
	NSURL *url = [NSURL URLWithString:[url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	printf("url = %s\n", [[url absoluteString] UTF8String]);
	return [NSMutableURLRequest requestWithURL:url];
}

- (IBAction)clickBackButton:(id)sender {
	[mUserImage setImage:nil];
	
	mTakePhotoButton.hidden = NO;
	mSendButton.hidden = YES;
	mInputView.hidden = NO;
	mResetButton.hidden = YES;
	mHomeButton.hidden = YES;
	mThankYouView.hidden = YES;
	
	mUserImage.hidden = YES; 
	
}
- (IBAction)clickResetButton:(id)sender {
	mUsernameTextField.text = @"";
	mPhoneTextField.text = @"";
	mEmailTextField.text = @"";
	[self clickBackButton:sender];
}


- (void)sendRegisterData:(id)listener name:(NSString*)name tel:(NSString*)tel email:(NSString*)email image:(UIImage*)image {
	//NSMutableURLRequest *request = [self create_request:@"http://api.hlpth.com/test_upload/"];
	
	NSString *submit_url;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	submit_url = [prefs objectForKey:@"mSubmitUrl"];
	if(!submit_url)
		submit_url = DEFAULT_SUBMIT_URL;
	
	NSMutableURLRequest *request = [self create_request:submit_url];
	
	
	HttpRequest *http_request = [[[HttpRequest alloc] init] autorelease];
	http_request->mListener = listener;
	
	//[http_request cancel_connect];
	assert(http_request.connection == nil);
	
	NSMutableData *post_data = [NSMutableData data];
	
	NSMutableDictionary *post_data_arr = [NSMutableDictionary dictionaryWithCapacity:0];
	[post_data_arr setObject:name forKey:@"Register[name]"];
	[post_data_arr setObject:tel forKey:@"Register[phone]"];
	[post_data_arr setObject:email forKey:@"Register[email]"];
	[post_data_arr setObject:@"0" forKey:@"Register[hidden]"];	
	NSString *post_data_multipart = [self arrayToMultipart:post_data_arr boundary:BOUNDARY];
	NSData *image_data = UIImageJPEGRepresentation(image, 1.0);
	post_data_multipart = [post_data_multipart stringByAppendingFormat:@"--%@\r\n", BOUNDARY];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Disposition: form-data; name=\"Register[image]\"; filename=\"save.jpg\"\r\n"];
	post_data_multipart = [post_data_multipart stringByAppendingString:@"Content-Type: image/jpeg\r\n\r\n"];
	[post_data appendData:[post_data_multipart dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	[post_data appendData:image_data];
	NSString *end_str = [NSString stringWithFormat:@"\r\n--%@--", BOUNDARY];
	[post_data appendData:[end_str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	
	
	
	
	
	
	
	
	[request setHTTPMethod:@"POST"];
	// Normal post
	//if(post_data_str){
	//	post_data = [NSMutableData data];
	//	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	//	NSString *postLength = [NSString stringWithFormat:@"%d", [post_data_str length]]; 
	//	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	//	[post_data appendData:[post_data_str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
	//}
	// Multipart post
	//else if(post_data){
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=\"%@\"", BOUNDARY] forHTTPHeaderField:@"Content-Type"];
	NSString *postLength = [NSString stringWithFormat:@"%d", [post_data length]]; 
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];  
	//}
	
	[request setHTTPBody:post_data];
	
	
	http_request.connection = [NSURLConnection connectionWithRequest:request delegate:http_request];
	assert(http_request.connection != nil);
	
	// Tell the UI we're receiving.
    [http_request _receiveDidStart];
}

- (IBAction)clickSubmitButton:(id)sender {
	mActivityLoading.hidden = NO;
	[self sendRegisterData:self name:mUsernameTextField.text tel:mPhoneTextField.text email:mEmailTextField.text image:mUserImage.image];
}


- (IBAction)textFieldFinished:(id)sender {
	[sender resignFirstResponder];
}

- (void)receivedResponse {
	printf("done\n");
	mActivityLoading.hidden = YES;

	mThankYouView.hidden = NO;
	mInputView.hidden = YES;
	mHomeButton.hidden = NO;
	mResetButton.hidden = YES;
	mSendButton.enabled = NO;

	mThankYouView.hidden = NO;
	mHomeButton.hidden = NO;

	
	
	/*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" 
													message:@"Information sent." 
												   delegate:nil 
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	*/
}

- (void)addDataToRegisterDataArray:(NSString*)name email:(NSString*)email tel:(NSString*)tel filename:(NSString*)filename {
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
	[dict setObject:name forKey:@"name"];
	[dict setObject:email forKey:@"email"];
	[dict setObject:tel forKey:@"tel"];
	[dict setObject:filename forKey:@"filename"];
	
	[mRegisterDataArray addObject:dict];
}

- (void)savemRegisterDataArray {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:mRegisterDataArray forKey:@"mRegisterDataArray"];
    [defaults synchronize];	
}

- (void)saveDataIniPad {
	NSData *image_data = UIImageJPEGRepresentation(mUserImage.image, 1.0);
	
	NSDate *date = [NSDate date];
	NSString *filename = [NSString stringWithFormat:@"img_%f.jpg", [date timeIntervalSince1970]];
	[self saveFile:filename data:image_data];
	
	
	UIImage *resize_image = [ImageUtil resizeImage:mUserImage.image scaledToSize:CGSizeMake(44.0, 44.0) 
							  scaleFactor:1.0
									   ox:0
									   oy:0];

	[self addDataToRegisterDataArray:mUsernameTextField.text email:mEmailTextField.text tel:mPhoneTextField.text filename:filename];
	[self savemRegisterDataArray];
	
	[mViewSetting addRegisterData:resize_image name:mUsernameTextField.text email:mEmailTextField.text tel:mPhoneTextField.text filename:filename];
}

- (IBAction)clickHomeButton:(id)sender {
	[self presentModalViewController:mViewHome animated:YES];	
	[self clickResetButton:nil];

}

- (IBAction)clickSettingButton:(id)sender {
	[self presentModalViewController:mViewSetting animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 10) ? NO : YES;
}


@end
