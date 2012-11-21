//
//  MathPlay.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 10/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "MathPlay.h"
//#import "MathMenu.h"
#import "MathResult.h"
#import "MathOptions.h"

@interface MathPlay ()

@end

@implementation MathPlay
//@synthesize goodAnswers;
//@synthesize badAnswers;

//NSMutableArray *goodAnswers;
//NSMutableArray *badAnswers;

NSString *question;
NSString *currentQuestion;
int res;
int r1;
int r2;
//NSString *wrongAnswerArray[3];
NSMutableArray *wrongAnswerArray;
//NSMutableArray *goodAnswers;
//NSMutableArray *badAnswers;
NSString *btnTitle;
NSString *result;
NSString *rightAnswer;
NSString *wrongNumber;
/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"playToResult"]) {
 MathResult *destViewController = segue.destinationViewController;
 [destViewController setGoodAnswers2:goodAnswers];
 [destViewController setWrongAnswers2:badAnswers];
 }
 }
 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"playToResult"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MathResult *destViewController = segue.destinationViewController;
        //NSString *good;
        //NSString *wrong;
        /*
         for (NSString *s in goodAnswers) {
         good = [NSString stringWithFormat:@"%@ \r %@",good,s];
         }
         for (NSString *s in badAnswers) {
         wrong = [NSString stringWithFormat:@"%@\n%@",wrong,s];
         }
         */
        //NSLog(good);
        //NSLog(wrong);
        destViewController.goodAnswersResult = goodAnswers;
        destViewController.wrongAnswersResult = badAnswers;
        
        //destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
    }
}

-(IBAction)answerPressed:(id)sender{
    if (numberOfQuestions==[_numberOfQuestionsPlay intValue]) {
        /*
         for (NSString *s in goodAnswers) {
         lblGoodAnswers.text = [NSString stringWithFormat:@"%@",s];
         NSLog(s);
         }
         for (NSString *s in badAnswers) {
         lblBadAnswers.text = [lblBadAnswers.text stringByAppendingString:s];
         NSLog(s);
         }
         */
        [self performSegueWithIdentifier: @"playToResult" sender: self];
        //UIViewController *openMathMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"MathResultID"];
        //[self presentViewController:openMathMenu animated:YES completion:nil];
    } else {
        btnTitle = [NSString stringWithFormat:@"%@",[sender titleForState:UIControlStateNormal]];
        result = [NSString stringWithFormat:@"%i",res];
        NSLog(@"btnTitle: %@",btnTitle);
        NSLog(@"Result: %@",result);
        switch ([sender tag]) {
            case 1:
                if ([btnTitle isEqualToString:result]) {
                    [goodAnswers addObject:[NSString stringWithFormat:@"%i + %i = %@",r1,r2,rightAnswer]];
                }else{
                    [badAnswers addObject:[NSString stringWithFormat:@"%i + %i ≠ %@",r1,r2,wrongNumber]];
                }
                break;
            case 2:
                if ([btnTitle isEqualToString:result]) {
                    [goodAnswers addObject:[NSString stringWithFormat:@"%i + %i = %@",r1,r2,rightAnswer]];
                }else{
                    [badAnswers addObject:[NSString stringWithFormat:@"%i + %i ≠ %@",r1,r2,wrongNumber]];
                }
                break;
            case 3:
                if ([btnTitle isEqualToString:result]) {
                    [goodAnswers addObject:[NSString stringWithFormat:@"%i + %i = %@",r1,r2,rightAnswer]];
                }else{
                    [badAnswers addObject:[NSString stringWithFormat:@"%i + %i ≠ %@",r1,r2,wrongNumber]];
                }
                break;
            case 4:
                if ([btnTitle isEqualToString:result]) {
                    [goodAnswers addObject:[NSString stringWithFormat:@"%i + %i = %@",r1,r2,rightAnswer]];
                }else{
                    [badAnswers addObject:[NSString stringWithFormat:@"%i + %i ≠ %@",r1,r2,wrongNumber]];
                }
                break;
            default:
                break;
        }
        
        numberOfQuestions += 1;
        [self newQuestion];
    }
}

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
        UIViewController *openMathMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"MathMenuID"];
        [self presentViewController:openMathMenu animated:YES completion:nil];
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
    //we starten met vraag 1 dus aantal vragen op 1 zetten
    numberOfQuestions = 1;
    //wanneer de view geload word gaan we direct onze eerste vraag genereren
    [self newQuestion];
	// Do any additional setup after loading the view.
    //wrongAnswerArray = [NSMutableArray arrayWithObjects: @"1", @"2", @"3", nil];
    NSLog(_difPlay);
    NSLog(_numberOfQuestionsPlay);
    badAnswers = [[NSMutableArray alloc] init];
    goodAnswers = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newQuestion{
    //random getal 0 tot 9
    r1 = arc4random() % 10;
    r2 = arc4random() % 10;
    
    res = r1 + r2;
    
    rightAnswer = [NSString stringWithFormat:@"%i",res];
    
    //vraag opmaken en aan label toekennen
    question = [NSString stringWithFormat:@"%i + %i =?", r1,r2];
    lblQuestion.text = question;
    
    //current question label invullen
    currentQuestion = [NSString stringWithFormat:@"Question: %i / %@",numberOfQuestions,_numberOfQuestionsPlay];
    lblCurrentQuestion.text = currentQuestion;
    
    //Array van fouten antwoorden vullen
    [self fillWrongAnswerArray];
    
    //antwoorden toekennen aan de buttons
    int indexNumber;
    NSMutableArray *indexArray;
    int memoryArray = 1;
    Boolean correctAnswerSet = false;
    int answerPosition = 0;
    
    NSString *indexNumberString;
    
    indexArray = [[NSMutableArray alloc] init];
    
    while (memoryArray <= 4) {
        
        
        indexNumber = arc4random() % 4 + 1;
        indexNumberString = [NSString stringWithFormat:@"%i",indexNumber];
        bool contains = false;
        
        for (NSString *i in indexArray) {
            if ([i isEqualToString:indexNumberString]) {
                contains = true;
            }
        }
        
        if (contains == true) {
            //niets doen
        }else{
            [indexArray addObject:indexNumberString];
            
            //NSLog([NSString stringWithFormat:@"%i",indexNumber]);
            memoryArray += 1;
            
            switch (indexNumber) {
                case 1:
                    if (correctAnswerSet == false) {
                        [btnOne setTitle:rightAnswer forState:UIControlStateNormal];
                        correctAnswerSet = true;
                    }else{
                        wrongNumber = (NSString *)wrongAnswerArray[answerPosition];
                        [btnOne setTitle:wrongNumber forState:UIControlStateNormal];
                        answerPosition += 1;
                    }
                    break;
                case 2:
                    if (correctAnswerSet == false) {
                        [btnTwo setTitle:rightAnswer forState:UIControlStateNormal];
                        correctAnswerSet = true;
                    }else{
                        wrongNumber = (NSString *)wrongAnswerArray[answerPosition];
                        [btnTwo setTitle:wrongNumber forState:UIControlStateNormal];
                        answerPosition += 1;
                    }
                    break;
                case 3:
                    if (correctAnswerSet == false) {
                        [btnThree setTitle:rightAnswer forState:UIControlStateNormal];
                        correctAnswerSet = true;
                    }else{
                        wrongNumber = (NSString *)wrongAnswerArray[answerPosition];
                        [btnThree setTitle:wrongNumber forState:UIControlStateNormal];
                        answerPosition += 1;
                    }
                    break;
                case 4:
                    if (correctAnswerSet == false) {
                        [btnFour setTitle:rightAnswer forState:UIControlStateNormal];
                        correctAnswerSet = true;
                    }else{
                        wrongNumber = (NSString *)wrongAnswerArray[answerPosition];
                        [btnFour setTitle:wrongNumber forState:UIControlStateNormal];
                        answerPosition += 1;
                    }
                    break;
                default:
                    NSLog(@"Error occured at setting title to button");
                    break;
            }
        }
        contains = false;
    }
    
    //double wrongAnswer = [self newWrongAnswers];
    
    //NSLog(@"%f",wrongAnswer);
    
}
NSString *aString;
-(void) fillWrongAnswerArray{
    wrongAnswerArray = [[NSMutableArray alloc] init];
    //wrongAnswerArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    bool contains = false;
    int i = 0;
    while (i <= 2) {
        aString = [self newWrongAnswers];
        //NSLog(@"aStringNormal: %@", aString);
        /*
         if (wrongAnswerArray.count > 0) {
         for (int y = 0; y <= wrongAnswerArray.count-1; y++){
         NSString *temp = (NSString *)wrongAnswerArray[y];
         if (aString == temp) {
         contains = true;
         NSLog(@"%@ == %@",temp, aString);
         }
         }
         }
         */
        for (NSString *x in wrongAnswerArray) {
            if (aString == x) {
                contains = true;
            }
        }
        
        if (contains) {
            // do nothing
            //***controle moet nog uitgevoerd worden!
        } else {
            //wrongAnswerArray[i] = aString;
            //[wrongAnswerArray insertObject:aString atIndex:i];
            [wrongAnswerArray addObject:aString];
            //NSLog(@"aStringArray: %@", (NSString *)wrongAnswerArray[i]);
            i += 1;
        }
        contains = false;
        
    }
    
}



-(NSString *)newWrongAnswers{
    //verschil berekenen
    double dif = res - floor(res);
    NSInteger numberLength = [[NSString stringWithFormat:@"%g", dif]length];
    
    if (numberLength > 5) {
        numberLength = 5;
        //dif omvormen tot 3 na de komma
        
    }
    
    double rNumber = arc4random() % 10 +1;
    //NSLog(@"rNumber %f",rNumber);
    
    switch (numberLength) {
            //0.000
        case 5:
            rNumber = rNumber / 1000;
            break;
            //0.00
        case 4:
            rNumber = rNumber / 100;
            break;
            //0.0
        case 3:
            rNumber = rNumber / 10;
            break;
            //Niets doen
        case 1:
            break;
        default:
            NSLog(@"An error accured at switchcase numberlength");
            break;
    }
    
    double newNumber;
    //Random operator genereren
    int rOperator = arc4random() % 2;
    if (rOperator == 0) {
        newNumber = res - rNumber;
    }else{
        newNumber = res + rNumber;
    }
    NSString *wrongNumber = [NSString stringWithFormat:@"%f",newNumber];
    
    //converteren van double naar nsnumber
    //NSNumber *wrongNumber = [NSNumber numberWithDouble:newNumber];
    
    return wrongNumber;
}

@end
