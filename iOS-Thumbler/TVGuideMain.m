//
//  TVGuideMainViewController.m
//  iOS-Thumbler
//
//  Created by 2930533 on 11/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "TVGuideMain.h"

@interface TVGuideMainViewController ()

@end

@implementation TVGuideMainViewController
@synthesize lblStatus;
@synthesize pbarLoading;
@synthesize btnStartDownload;


-(IBAction)startDownloadPressed{
    //check if device is online
    if ([self isOnline]) {
        lblStatus.text = @"Device is online.";
    } else {
        lblStatus.text = @"Device is offline.";
    }
}

-(bool) isOnline {
    return true;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
