//
//  ViewSetting.m
//  RegisterMan
//
//  Created by saranpol on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewSetting.h"
#import "ImageUtil.h"

@implementation ViewSetting

@synthesize mTableView;
@synthesize tmpCell;

@synthesize mSubmitUrl;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *url = [prefs objectForKey:@"mSubmitUrl"];
	if(!url)
		mSubmitUrl.text = DEFAULT_SUBMIT_URL;
	else
		mSubmitUrl.text = url;

	mCellRegisterList = [[NSMutableArray alloc] init];
	
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}



- (IBAction)clickBackButton:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)clickSaveButton:(id)sender {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:mSubmitUrl.text forKey:@"mSubmitUrl"];
	[prefs synchronize];
}

- (IBAction)clickDefaultButton:(id)sender {
	mSubmitUrl.text = DEFAULT_SUBMIT_URL;
	[self clickSaveButton:nil];
}

- (void)dealloc {
	[mTableView release];
	[mSubmitUrl release];
	[mCellRegisterList release];
	
    [super dealloc];
}

- (IBAction)textFieldFinished:(id)sender {
	[sender resignFirstResponder];
}




- (void)setupRegisterData:(NSMutableArray*)data {
	for(NSDictionary *a in data){
		
		
		
		NSString *name = [a objectForKey:@"name"];
		NSString *email = [a objectForKey:@"email"];
		NSString *tel = [a objectForKey:@"tel"];
		NSString *filename = [a objectForKey:@"filename"];

		//printf("name %s filename %s\n", [name UTF8String], [filename UTF8String]);
		
		NSData *image_data = [mRegisterManViewController contentOfFile:filename];
		UIImage *image = [UIImage imageWithData:image_data];
		
		UIImage *resize_image = [ImageUtil resizeImage:image scaledToSize:CGSizeMake(44.0, 44.0) 
										   scaleFactor:1.0
													ox:0
													oy:0];
		
		[self addRegisterData:resize_image name:name email:email tel:tel filename:filename];
	}
}


- (void)addRegisterData:(UIImage*)image name:(NSString*)name email:(NSString*)email tel:(NSString*)tel filename:(NSString*)filename{
	[[NSBundle mainBundle] loadNibNamed:@"CellRegister" owner:self options:nil];
	CellRegister *cell = tmpCell;
	self.tmpCell = nil;
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	// save image as file and keep the path
	
	[cell->mImageView setImage:image];
	[cell->mUsername setText:name];
	[cell->mEmail setText:email];
	[cell->mTel setText:tel];
	cell->mFilename = [[NSString alloc] initWithString:filename];
	
	[mCellRegisterList addObject:cell];
	[mTableView reloadData];
	
	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [mCellRegisterList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	/*
	 static NSString *CellIdentifier = @"CellNotification";
	 
	 CellNotification *cell = (CellNotification *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 if (cell == nil) {
	 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	 [[NSBundle mainBundle] loadNibNamed:@"CellNotification-iPad" owner:self options:nil];
	 else
	 [[NSBundle mainBundle] loadNibNamed:@"CellNotification" owner:self options:nil];
	 cell = tmpCell;
	 self.tmpCell = nil;
	 }
	 */
	
	
	if (indexPath.row < [mCellRegisterList count])
		return [mCellRegisterList objectAtIndex:indexPath.row];
	

	
	return nil;
	
	
}




@end
