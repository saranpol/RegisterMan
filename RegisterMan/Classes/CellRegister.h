//
//  CellRegister.h
//  RegisterMan
//
//  Created by saranpol on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellRegister : UITableViewCell {
@public
	IBOutlet UIImageView *mImageView;
	IBOutlet UILabel *mUsername;
	IBOutlet UILabel *mEmail;
	IBOutlet UILabel *mTel;
	IBOutlet UIActivityIndicatorView *mLoading;
	NSString *mFilename;
	BOOL mSuccess;

}

@property (nonatomic, retain) IBOutlet UIImageView *mImageView;
@property (nonatomic, retain) IBOutlet UILabel *mUsername;
@property (nonatomic, retain) IBOutlet UILabel *mEmail;
@property (nonatomic, retain) IBOutlet UILabel *mTel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *mLoading;

- (IBAction)clickSendButton:(id)sender;

@end
