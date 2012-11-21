//
//  MathResult.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 19/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "MathResult.h"
//#import "MathOptions.h"
//#import "MathPlay.h"

@interface MathResult ()

@end

@implementation MathResult
@synthesize goodAnswersResult;
@synthesize wrongAnswersResult;

//@synthesize lblBadAnswers;
//@synthesize lblGoodAnswers;

//UILabel *lblGoodAnswers;
//UILabel *lblBadAnswers;

//@synthesize goodAnswers2;
//@synthesize wrongAnswers2;



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
    //wrongAnswers2 = [[NSMutableArray alloc] init];
    //goodAnswers2 = [[NSMutableArray alloc] init];
    /*
     for (NSString *s in goodAnswers2) {
     lblGoodAnswers.text = [lblGoodAnswers.text stringByAppendingString:s];
     }
     for (NSString *s in wrongAnswers2) {
     lblBadAnswers.text = [lblBadAnswers.text stringByAppendingString:s];
     }
     */
    /*
     NSLog([NSString stringWithFormat:@"%@",dif]);
     for (NSString *s in goodAnswers) {
     lblGoodAnswers.text = [lblGoodAnswers.text stringByAppendingString:s];
     }
     for (NSString *s in badAnswers) {
     lblBadAnswers.text = [lblBadAnswers.text stringByAppendingString:s];
     }
     */
    //NSLog(@"good: %@",goodAnswersResult);
    //NSLog(@"bad: %@",wrongAnswersResult);
    
    //lblGoodAnswers.text = goodAnswersResult;
    //lblBadAnswers.text = wrongAnswersResult;
    
    //NSLog([NSString stringWithFormat:@"%@",goodAnswersResult]);
    //NSLog([NSString stringWithFormat:@"%@",wrongAnswersResult]);
    NSString *goodResult;
    NSString *wrongResult;
    
    lblScore.text = [NSString stringWithFormat:@"Score: %i/%i",[goodAnswersResult count],[wrongAnswersResult count]];
    goodResult = [goodAnswersResult componentsJoinedByString:@"\n"];
    wrongResult = [wrongAnswersResult componentsJoinedByString:@"\n"];
    /*
     for (NSString *s in goodAnswersResult) {
     goodResult = [NSString stringWithFormat:@"%@ \n %@",goodResult,s];
     }
     for (NSString *s in wrongAnswersResult) {
     goodResult = [NSString stringWithFormat:@"%@ \n %@",wrongResult,s];
     }
     */
    lblGoodAnswers.text = goodResult;
    lblBadAnswers.text = wrongResult;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
