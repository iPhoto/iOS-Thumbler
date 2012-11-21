//
//  MathPlay.h
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 10/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>

//extern NSMutableArray *goodAnswers;
//extern NSMutableArray *badAnswers;

@interface MathPlay : UIViewController{
    int numberOfQuestions;
    
    IBOutlet UIButton *btnOne;
    IBOutlet UIButton *btnTwo;
    IBOutlet UIButton *btnThree;
    IBOutlet UIButton *btnFour;
    
    IBOutlet UILabel *lblQuestion;
    IBOutlet UILabel *lblCurrentQuestion;
    
    NSMutableArray *goodAnswers;
    NSMutableArray *badAnswers;
    
}

//@property (retain, nonatomic) NSMutableArray *goodAnswers;
//@property (retain, nonatomic) NSMutableArray *badAnswers;

@property (retain, nonatomic) NSString *difPlay;
@property (retain, nonatomic) NSString *numberOfQuestionsPlay;

-(IBAction)quitPressed;
-(IBAction)answerPressed:(id)sender;

@end
