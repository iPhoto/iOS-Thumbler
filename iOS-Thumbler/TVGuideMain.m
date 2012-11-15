//
//  TVGuideMainViewController.m
//  iOS-Thumbler
//
//  Created by 2930533 on 11/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "TVGuideMain.h"
#import "TFHpple.h"
#import "Programma.h"

@interface TVGuideMain ()

@end

@implementation TVGuideMain

@synthesize lblStatus;
@synthesize pbarLoading;
@synthesize btnStartDownload;

-(IBAction)startDownloadPressed{
    //check if device is online
    if ([self isOnline]) {
        NSLog(@"Info: %@", @"Device is online.");
        
        [self.lblStatus setText:@"Device is online."];
        
        dispatch_queue_t queue = dispatch_queue_create("be.phl.iOS-Thumbler", NULL);
        dispatch_async(queue, ^{
            //code to executed in the background
            [self doTask];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //code to be executed on the main thread when background task is finished
                if (taskSucces) {
                    [self.lblStatus setText:@"Download was succesfull."];
                    NSLog(@"Info: %@", @"Download was succesfull.");
                    
                    //load new view and pass data to it
                    UIViewController *TVGuideDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TVGuideDetailViewID"];
                    
                    [self presentViewController:TVGuideDetailViewController animated:YES completion:nil];
                } else {
                    [self.lblStatus setText:@"Something went wrong."];
                    [self.btnStartDownload setTitle:@"Retry?" forState:UIControlStateNormal];
                    NSLog(@"Info: %@", @"Something went wrong.");
                }
            });
        });
        dispatch_sync(queue, ^{});
    } else {
        NSLog(@"Info: %@", @"Something went wrong.");
        
        [self.lblStatus setText:@"Device is offline."];
    }
}

-(void) doTask{
    @try {
        // Try something
        // 1
        NSURL *programmasUrl = [NSURL URLWithString:@"http://www.mtv.com/ontv/schedule/"];
        NSData *programmasHtmlData = [NSData dataWithContentsOfURL:programmasUrl];
        
        // 2
        TFHpple *programmasParser = [TFHpple hppleWithHTMLData:programmasHtmlData];
        
        // 3
        NSString *programmasXpathQueryString = @"//*[@id='schedule']/tbody/tr";
        NSArray *programmasNodes = [programmasParser searchWithXPathQuery:programmasXpathQueryString];
        
        // 4
        NSMutableArray *newProgrammas = [[NSMutableArray alloc] initWithCapacity:0];
        if (programmasNodes.count > 0) {
            for (TFHppleElement *element in programmasNodes) {
                // 5
                Programma *programma = [[Programma alloc] init];
                [newProgrammas addObject:programma];
                
                // 6
                //programma.tijd = [[element firstChild] content];
                //programma.titel = [element objectForKey:@"href"];
                //programma.omschrijving = @"Test omschrijving";
                //programma.rating = @"MTV-14";
                programma.tijd = @"Test tijd";
                programma.titel = @"Test titel";
                programma.omschrijving = @"Test omschrijving";
                programma.rating = @"MTV-14";
            }
            
            // 7
            _objects = newProgrammas;
            taskSucces = true;
            
        } else {
            taskSucces = false;
        }
    }
    @catch (NSException * e) {
        taskSucces = false;
        NSLog(@"Exception: %@", e);
    }
}

-(bool) isOnline {
    SCNetworkReachabilityFlags flags;
    BOOL receivedFlags;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"www.google.com" UTF8String]);
    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    
    if (!receivedFlags || (flags == 0) )
    {
        // internet not available
        return false;
    } else {
        // internet available
        return true;
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
    
	// Do any additional setup after loading the view.
    taskSucces = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
