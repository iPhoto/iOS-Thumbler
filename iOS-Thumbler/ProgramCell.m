//
//  ProgramCell.m
//  iOS-Thumbler
//
//  Created by Smeets Joey on 17/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "ProgramCell.h"

@implementation ProgramCell

@synthesize lblTime = _Time;
@synthesize lblTitle = _Title;
@synthesize lblDescription = _Description;
@synthesize picRating = _Rating;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
