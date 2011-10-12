//
//  RegisterManViewController.h
//  RegisterMan
//
//  Created by saranpol on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterManAppDelegate.h"
#import "ViewHome.h"
#import "ImageUtil.h"

@class ViewSetting;

@interface RegisterManViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
@public
	IBOutlet UIImageView *mUserImage;
	IBOutlet UITextField *mUsernameTextField;
	IBOutlet UITextField *mPhoneTextField;
	IBOutlet UITextField *mEmailTextField;
	IBOutlet UIButton *mHomeButton;
	IBOutlet UIButton *mSendButton;
	IBOutlet UIButton *mResetButton;
	IBOutlet UIButton *mTakePhotoButton;
	IBOutlet UIView *mActivityLoading;
	IBOutlet UIView *mInputView;
	IBOutlet UIView *mThankYouView;
	UIImagePickerController *mImagePicker;
	UIPopoverController *mPopoverController;
	
	
	ViewHome *mViewHome;
	ViewSetting *mViewSetting;
	BOOL mFirstShow;
	
	// File Manager
	NSError *mError;
	NSString *dataPath;
	NSString *filePath;
	
	
	NSMutableArray *mRegisterDataArray;
}

@property (nonatomic, retain) IBOutlet UIImageView *mUserImage;
@property (nonatomic, retain) IBOutlet UITextField *mUsernameTextField;
@property (nonatomic, retain) IBOutlet UITextField *mPhoneTextField;
@property (nonatomic, retain) IBOutlet UITextField *mEmailTextField;
@property (nonatomic, retain) IBOutlet UIButton *mHomeButton;
@property (nonatomic, retain) IBOutlet UIButton *mSendButton;
@property (nonatomic, retain) IBOutlet UIButton *mResetButton;
@property (nonatomic, retain) IBOutlet UIButton *mTakePhotoButton;
@property (nonatomic, retain) IBOutlet UIView *mActivityLoading;
@property (nonatomic, retain) IBOutlet UIView *mInputView;
@property (nonatomic, retain) IBOutlet UIView *mThankYouView;


// File Manager
@property (nonatomic, copy) NSString *dataPath;
@property (nonatomic, copy) NSString *filePath;

- (NSData*)contentOfFile:(NSString *)fName;

- (void)sendRegisterData:(id)listener name:(NSString*)name tel:(NSString*)tel email:(NSString*)email image:(UIImage*)image;

- (void)addDataToRegisterDataArray:(NSString*)name email:(NSString*)email tel:(NSString*)tel filename:(NSString*)filename;
- (void)savemRegisterDataArray;

- (IBAction)clickCameraButton:(id)sender;
- (IBAction)clickLibraryButton:(id)sender;
- (IBAction)clickBackButton:(id)sender;
- (IBAction)clickResetButton:(id)sender;
- (IBAction)clickSubmitButton:(id)sender;
- (IBAction)clickHomeButton:(id)sender;
- (IBAction)clickSettingButton:(id)sender;
- (IBAction)textFieldFinished:(id)sender;
- (IBAction)textFieldClick:(id)sender;
- (void)receivedResponse;
- (void)saveDataIniPad;
@end

