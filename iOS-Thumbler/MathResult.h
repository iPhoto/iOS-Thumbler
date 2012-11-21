//
//  MathResult.h
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 19/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MathPlay.h"

//extern UILabel *lblGoodAnswers;
//extern UILabel *lblBadAnswers;

@interface MathResult : UIViewController{
    IBOutlet UILabel *lblGoodAnswers;
    IBOutlet UILabel *lblBadAnswers;
    IBOutlet UILabel *lblScore;
    
}

@property (nonatomic, strong) NSMutableArray *goodAnswersResult;
@property (nonatomic, strong) NSMutableArray *wrongAnswersResult;

//@property (nonatomic, strong)IBOutlet UILabel *lblGoodAnswers;
//@property (nonatomic, strong)IBOutlet UILabel *lblBadAnswers;

//@property(nonatomic) NSMutableArray *goodAnswers2;
//@property(nonatomic) NSMutableArray *wrongAnswers2;


@end