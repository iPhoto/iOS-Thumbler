//
//  MathOptions.h
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 18/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#define QUESTIONS 0

//extern NSString *dif;

@interface MathOptions : UIViewController
<UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UISegmentedControl *control;
    IBOutlet UIPickerView *pickerQuestions;
    
    NSMutableArray *questionArray;
}

@property (retain, nonatomic) NSString *dif;
@property (strong, nonatomic) IBOutlet UILabel *lblQuestions;
@property (strong, nonatomic) IBOutlet UIView *PickerViewContainer;

-(IBAction)segmentController;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnShow:(id)sender;

@end
