//
//  TVGuideDetailViewController.h
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 12/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVGuideDetailViewController : UITableViewController

@property(nonatomic) NSMutableArray *_objectsB;
- (id)initWithObjects:(NSMutableArray *)programmaObjects;

@end
