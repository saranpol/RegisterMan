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
#import "ViewSetting.h"

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


- (IBAction)clickCameraButton:(id)sender;
- (IBAction)clickLibraryButton:(id)sender;
- (IBAction)clickBackButton:(id)sender;
- (IBAction)clickResetButton:(id)sender;
- (IBAction)clickSubmitButton:(id)sender;
- (IBAction)clickHomeButton:(id)sender;
- (IBAction)clickSettingButton:(id)sender;
- (IBAction)textFieldFinished:(id)sender;
- (void)receivedResponse;
- (void)saveDataIniPad;
@end

