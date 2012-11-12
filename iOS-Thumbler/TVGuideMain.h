//
//  TVGuideMainViewController.h
//  iOS-Thumbler
//
//  Created by 2930533 on 11/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>


@interface TVGuideMain : UIViewController {
    UIActivityIndicatorView *pbarLoading;
    UILabel *lblStatus;
    UIButton *btnStartDownload;
    BOOL taskSucces;
    NSMutableArray *_objects;
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView *pbarLoading;
@property(nonatomic, retain) IBOutlet UILabel *lblStatus;
@property(nonatomic, retain) IBOutlet UIButton *btnStartDownload;
-(IBAction)startDownloadPressed;


@end
