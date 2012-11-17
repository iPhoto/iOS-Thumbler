//
//  ProgramCell.h
//  iOS-Thumbler
//
//  Created by Smeets Joey on 17/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblTime;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;
@property (nonatomic, weak) IBOutlet UIImageView *picRating;

@end
