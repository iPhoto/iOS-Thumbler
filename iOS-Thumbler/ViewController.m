//
//  ViewController.m
//  iOS-Thumbler
//
//  Created by 2930533 on 07/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycle

-(IBAction)pageInfo{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:@"Currently displaying view one"
                                                    delegate:self
                                                    cancelButtonTitle:@"Ok"
                                                    otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
