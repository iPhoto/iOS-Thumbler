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
#import "TVGuideDetailViewController.h"

@interface TVGuideMain ()

@end

@implementation TVGuideMain

@synthesize lblStatus;
@synthesize pbarLoading;
@synthesize btnStartDownload;

-(IBAction)startDownloadPressed{
    //check if device is online
    if ([self isOnline]) {
        [lblStatus setText:@"Device is online."];
        [lblStatus setHidden:false];
        
        dispatch_queue_t queue = dispatch_queue_create("be.phl.iOS-Thumbler", NULL);
        dispatch_async(queue, ^{
            //code to executed in the background
            [lblStatus setText:@"Downloading data..."];
            [pbarLoading setHidden:false];
            [self doTask];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //code to be executed on the main thread when background task is finished
                if (taskSucces) {
                    [lblStatus setText:@"Download was succesfull."];
                    [pbarLoading setHidden:true];
                    
                    //load new view and pass data to it
//                    UITableViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"TVGuideDetailViewID"];
//                    [self presentViewController:detailView animated:YES completion:nil];
                    
//                    TVGuideDetailViewController *destinationController = [[TVGuideDetailViewController alloc] initWithObjects:_objectsA];
//                    [self presentViewController:destinationController animated:YES completion:nil];
                    
                    [self performSegueWithIdentifier:@"showProgramList" sender:nil];
                    
                } else {
                    [lblStatus setText:@"Something went wrong."];
                    [pbarLoading setHidden:true];
                    [btnStartDownload setTitle:@"Retry?" forState:UIControlStateNormal];
                }
            });
        });
        dispatch_sync(queue, ^{});
    } else {
        NSLog(@"Info: %@", @"Something went wrong.");
        
        [lblStatus setText:@"Device is offline."];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showProgramList"]) {
        TVGuideDetailViewController *destViewController = segue.destinationViewController;
//        destViewController._objectsB = [_objectsA copy];
        [destViewController set_objectsB:_objectsA];
    }
}

-(void) doTask{
    @try {
        // Try something: sit on your arse and parse!
        // 1
        NSURL *programmasUrl = [NSURL URLWithString:@"http://www.mtv.com/ontv/schedule/"];
        NSData *programmasHtmlData = [NSData dataWithContentsOfURL:programmasUrl];
        
        // 2
        TFHpple *programmasParser = [TFHpple hppleWithData:programmasHtmlData isXML:NO];
        
        // 3
//        NSArray *programmasTabel = [programmasParser searchWithXPathQuery:@"//*[@id='schedule']"];
        NSArray *programmaTijden = [programmasParser searchWithXPathQuery:@"//*/td[@class='lftLne']"];
        NSArray *programmaTitels = [programmasParser searchWithXPathQuery:@"//*/td/b/a"];
        NSArray *programmaOmschrijving = [programmasParser searchWithXPathQuery:@"//*/td/span"];
        NSArray *programmaRating = [programmasParser searchWithXPathQuery:@"//*/td[@class='rhtLne']/a"];
        
//        NSLog(@"Info: %@", programmasTabel);
//        NSLog(@"Info: %@", programmaTijden);
//        NSLog(@"Info: %@", programmaTitels);
//        NSLog(@"Info: %@", programmaOmschrijving);
//        NSLog(@"Info: %@", programmaRating);
        
        // 4
        NSMutableArray *newProgrammas = [[NSMutableArray alloc] initWithCapacity:programmaTijden.count];
        if (programmaTijden.count > 0) {
            for (int i = 1; i <= programmaTijden.count-2; i++) {
                // 5
                Programma *programma = [[Programma alloc] init];
                // 6
                programma.tijd = [[programmaTijden objectAtIndex:i] content];
                programma.titel = [[programmaTitels objectAtIndex:i] content];
                programma.omschrijving = [[programmaOmschrijving objectAtIndex:i] content];
                programma.rating = [[programmaRating objectAtIndex:i] content];
                
                [newProgrammas addObject:programma];
            }
            
            // 7
            _objectsA = newProgrammas;
            taskSucces = true;
            
        } else {
            taskSucces = false;
        }
    }
    @catch (NSException * e) {
        taskSucces = false;
        NSLog(@"Exception (doTask): %@", e);
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
    [lblStatus setHidden:true];
    [pbarLoading setHidden:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
