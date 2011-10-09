//
//  ViewSetting.m
//  RegisterMan
//
//  Created by saranpol on 9/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewSetting.h"


@implementation ViewSetting
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
	[mSubmitUrl release];
    [super dealloc];
}

- (IBAction)textFieldFinished:(id)sender {
	[sender resignFirstResponder];
}




@end
