//
//  MathMenu.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 11/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "MathMenu.h"
#import "MathPlay.h"

@interface MathMenu ()

@end

@implementation MathMenu
@synthesize difMenu;
@synthesize NumberOfQuestionsMenu;

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
    NSLog(difMenu);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnOptions:(id)sender {
    UIViewController *openMathMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"MathOptionsID"];
    [self presentViewController:openMathMenu animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"menuToPlay"]) {
        
        MathPlay *destViewController = segue.destinationViewController;
        
        if ([difMenu length] == 0) {
            difMenu = @"EASY";
        }
        if ([NumberOfQuestionsMenu length] == 0) {
            NumberOfQuestionsMenu = @"5";
        }
        destViewController.difPlay = difMenu;
        destViewController.numberOfQuestionsPlay = NumberOfQuestionsMenu;
    }
}

@end
