//
//  CameraViewController.h
//  iOS-Thumbler
//
//  Created by Geoffry Nagy on 20/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>

-(void)showLoginView;
@end