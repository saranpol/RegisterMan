//
//  ViewSetting.h
//  RegisterMan
//
//  Created by saranpol on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterManAppDelegate.h"

@interface ViewSetting : UIViewController {
	IBOutlet UITextField *mSubmitUrl;
}

@property (nonatomic, retain) IBOutlet UITextField *mSubmitUrl;

- (IBAction)clickBackButton:(id)sender;
- (IBAction)clickSaveButton:(id)sender;
- (IBAction)clickDefaultButton:(id)sender;
- (IBAction)textFieldFinished:(id)sender;
@end
