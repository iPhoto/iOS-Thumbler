//
//  MathOptions.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 18/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "MathOptions.h"
#import "MathMenu.h"

@interface MathOptions ()

@end

@implementation MathOptions
//@synthesize dif;

NSString *dif;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"difToPlay"]) {
        
        MathMenu *destViewController = segue.destinationViewController;
        destViewController.difMenu = dif;
        //NSLog([NSString stringWithFormat:@"%@",_lblQuestions.text]);
        destViewController.NumberOfQuestionsMenu = [NSString stringWithFormat:@"%@",_lblQuestions.text]  ;
        
    }
}
//aantal verschillende elementen dat zich bevinden in de picker. in dit geval 1.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//aantal elementen tellen in de array voor te weten hoeveel rijen er nodig zijn in de picker.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == QUESTIONS)
        return [questionArray count];
    
    return 0;
}
//elementen toevoegen aan de picker
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == QUESTIONS)
        return [questionArray objectAtIndex:row];
    
    return 0;
}
//geselecteerd nummer toekennen aan label
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _lblQuestions.text = [questionArray objectAtIndex:[pickerView selectedRowInComponent:0]];
}

-(IBAction)segmentController{
    if(control.selectedSegmentIndex == 0){
        dif = @"EASY";
    }
    if(control.selectedSegmentIndex == 1){
        dif = @"MEDIUM";
    }
    if(control.selectedSegmentIndex == 2){
        dif = @"HARD";
    }
}

- (IBAction)btnClose:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _PickerViewContainer.frame = CGRectMake(0, 460, 320, 261);
    [UIView commitAnimations];
}

- (IBAction)btnShow:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _PickerViewContainer.frame = CGRectMake(0, 200, 320, 261);
    [UIView commitAnimations];
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
    questionArray = [[NSMutableArray alloc]init];
    [questionArray addObject:@"5"];
    [questionArray addObject:@"10"];
    [questionArray addObject:@"20"];
    [questionArray addObject:@"50"];
    
    _PickerViewContainer.frame = CGRectMake(0, 460, 320, 261);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
