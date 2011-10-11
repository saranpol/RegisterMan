//
//  CellRegister.m
//  RegisterMan
//
//  Created by saranpol on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CellRegister.h"
#import "RegisterManAppDelegate.h"
#import "RegisterManViewController.h"
#import "ViewSetting.h"

@implementation CellRegister

@synthesize mImageView;
@synthesize mUsername;
@synthesize mEmail;
@synthesize mTel;
@synthesize mLoading;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[mImageView release];
	[mUsername release];
	[mEmail release];
	[mTel release];
	[mFilename release];
	[mLoading release];
	
    [super dealloc];
}

- (IBAction)clickSendButton:(id)sender {
	NSData *image_data = [[RegisterManAppDelegate core]->viewController contentOfFile:mFilename];
	UIImage *image = [UIImage imageWithData:image_data];
	[[RegisterManAppDelegate core]->viewController sendRegisterData:self name:mUsername.text tel:mTel.text email:mEmail.text image:image];
	mSuccess = YES;
	mLoading.hidden = NO;
}

- (void)saveDataIniPad {
	// not success
	mSuccess = NO;
}

- (void)receivedResponse {
	mLoading.hidden = YES;
	if(mSuccess){
		[[RegisterManAppDelegate core]->viewController->mViewSetting->mCellRegisterList removeObject:self];
		[[RegisterManAppDelegate core]->viewController->mViewSetting->mTableView reloadData];
	}
	
}
@end
