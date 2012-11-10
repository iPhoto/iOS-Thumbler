//
//  MathPlay.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 10/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "MathPlay.h"
#import "MathMenu.h"

@interface MathPlay ()

@end

@implementation MathPlay

-(IBAction)quitPressed{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Quit game?"
                              message:@"Are you sure you want to quit the game?"
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Geen actie ondernemen.
    }
    else
    {
        // Ga naar Math Menu scherm        
    }
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
