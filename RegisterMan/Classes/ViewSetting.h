//
//  ViewSetting.h
//  RegisterMan
//
//  Created by saranpol on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterManAppDelegate.h"
#import "CellRegister.h"

@interface ViewSetting : UIViewController <UITableViewDelegate, UITableViewDataSource> {
@public
	IBOutlet UITableView *mTableView;
	IBOutlet CellRegister *tmpCell;
	IBOutlet UITextField *mSubmitUrl;
	
	NSMutableArray *mCellRegisterList;
}

@property (nonatomic, retain) IBOutlet UITableView *mTableView;
@property (nonatomic, assign) IBOutlet CellRegister *tmpCell;

@property (nonatomic, retain) IBOutlet UITextField *mSubmitUrl;


- (void)addRegisterData:(UIImage*)image name:(NSString*)name email:(NSString*)email tel:(NSString*)tel;

- (IBAction)clickBackButton:(id)sender;
- (IBAction)clickSaveButton:(id)sender;
- (IBAction)clickDefaultButton:(id)sender;
- (IBAction)textFieldFinished:(id)sender;
@end
