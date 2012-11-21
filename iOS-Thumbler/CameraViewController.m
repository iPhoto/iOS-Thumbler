//
//  CameraViewController.m
//  iOS-Thumbler
//
//  Created by Geoffry Nagy on 20/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//
#import "CameraViewController.h"
#import "GPUImage.h"
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CameraViewController ()
{
    UIImage *originalImage;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    CLLocation *location;
}

@property(nonatomic, weak) IBOutlet UIImageView *selectedImageView;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *filterButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *saveButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *cameraButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *loginButton;
-(IBAction)loginToFB;
-(IBAction)photoFromAlbum;
-(IBAction)photoFromCamera;
-(IBAction)applyImageFilter:(id)sender;
-(IBAction)saveImageToAlbum;
@end

@implementation CameraViewController
@synthesize selectedImageView, filterButton, saveButton, loginButton, cameraButton;

-(IBAction)photoFromAlbum
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

-(IBAction)photoFromCamera
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:photoPicker animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.saveButton.enabled = YES;
    self.filterButton.enabled = YES;
    
    //blijkbaar stript UIImage een img van al zijn metadata ..
    originalImage = [UIImage imageWithData:[self getImageWithMetaData:[info valueForKey:UIImagePickerControllerOriginalImage]]];
    //TODO NSLOG de metadata uit img vr check
    NSLog(@"current latitude, longitude en altitude : %f, %f, %f", location.coordinate.latitude, location.coordinate.longitude, location.altitude);
    //vertaal coords nr adres
    [self showLocation:location completionHandler:NULL];
    //TODO methode veranderen om GPScoords uit img te lezen
    
    [self.selectedImageView setImage:originalImage];
    [photoPicker dismissModalViewControllerAnimated:YES];
}

-(IBAction)saveImageToAlbum
{
    //TODO NSLOG de metadata gpscoords vr check
    UIImageWriteToSavedPhotosAlbum(self.selectedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    if(!error)
    {
        alertTitle = @"Image Saved";
        alertMessage = @"Image saved to photo album succesfully.";
    }
    else
    {
        alertTitle = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

-(IBAction)applyImageFilter:(id)sender
{
    UIActionSheet *filterActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Filter" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Grayscale", @"Sepia", @"Sketch", @"Pixellate", @"Color Invert", @"Toon", @"Pinch Distort", @"None", nil];
    [filterActionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    GPUImageFilter *selectedFilter;
    switch(buttonIndex) {
        case 0:
            selectedFilter = [[GPUImageGrayscaleFilter alloc] init];
            break;
        case 1:
            selectedFilter = [[GPUImageSepiaFilter alloc] init];
            break;
        case 2:
            selectedFilter = [[GPUImageSketchFilter alloc] init];
            break;
        case 3:
            selectedFilter = [[GPUImagePixellateFilter alloc] init];
            break;
        case 4:
            selectedFilter = [[GPUImageColorInvertFilter alloc] init];
            break;
        case 5:
            selectedFilter = [[GPUImageToonFilter alloc] init];
            break;
        case 6:
            selectedFilter = [[GPUImagePinchDistortionFilter alloc] init];
            break;
        case 7:
            selectedFilter = [[GPUImageFilter alloc] init];
            break;
        default:
            break;
    }
    UIImage *filteredImage = [selectedFilter imageByFilteringImage:originalImage];
    [self.selectedImageView setImage:filteredImage];
}

#pragma GPS method
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    location = newLocation;
}

//testmethode om locatie weer te geven
-(void)showLocation:(CLLocation *)location completionHandler:(CLGeocodeCompletionHandler)completionHandler
{
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
                       if (error == nil && [placemarks count] > 0) {
                           placemark = [placemarks lastObject];
                           NSLog(
                                 [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                  placemark.subThoroughfare, placemark.thoroughfare,
                                  placemark.postalCode, placemark.locality,
                                  placemark.administrativeArea,
                                  placemark.country]);
                       } else {
                           NSLog(@"%@", error.debugDescription);
                       }
                   } ];
}

-(NSMutableData *)getImageWithMetaData:(UIImage *) pImage
{
    NSData* pngData = UIImagePNGRepresentation(pImage);
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)pngData, NULL);
    NSDictionary *metadata = (__bridge NSDictionary *) CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    
    NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
    
    //GPS Dictionary
    NSMutableDictionary *GPSDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary]mutableCopy];
    if(!GPSDictionary)
    {
        GPSDictionary = [NSMutableDictionary dictionary];
    }
    
    [GPSDictionary setValue:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:(NSString *)kCGImagePropertyGPSLatitude];
    [GPSDictionary setValue:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:(NSString *)kCGImagePropertyGPSLongitude];
    
    NSString* ref;
    if(location.coordinate.latitude <0.0)
    {
        ref = @"S";
    }
    else
    {
        ref=@"N";
    }
    [GPSDictionary setValue:ref forKey:(NSString *)kCGImagePropertyGPSLatitudeRef];
    
    if(location.coordinate.longitude <0.0)
    {
        ref=@"W";
    }
    else
    {
        ref=@"E";
    }
    [GPSDictionary setValue:ref forKey:(NSString *)kCGImagePropertyGPSLongitudeRef];
    [GPSDictionary setValue:[NSNumber numberWithFloat: location.altitude] forKey:(NSString*)kCGImagePropertyGPSAltitude];
    
    //EXIF Dictionary
    NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString*) kCGImagePropertyExifDictionary]mutableCopy];
    if(!EXIFDictionary)
    {
        EXIFDictionary = [NSMutableDictionary dictionary];
    }
    
    [EXIFDictionary setObject:[NSDate date] forKey:(NSString*)kCGImagePropertyExifDateTimeOriginal];
    [EXIFDictionary setObject:[NSDate date] forKey:(NSString*)kCGImagePropertyExifDateTimeDigitized];
    
    //modified exifdata back to image's metadata
    [metadataAsMutable setObject:EXIFDictionary forKey:(NSString*)kCGImagePropertyExifDictionary];
    [metadataAsMutable setObject:GPSDictionary forKey:(NSString*)kCGImagePropertyGPSDictionary];
    
    CFStringRef UTI = CGImageSourceGetType(source);
    
    NSMutableData *dest_data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef) dest_data, UTI, 1, NULL);
    
    if(!destination)
    {
        dest_data = [pngData mutableCopy];
    }
    else
    {
        CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef) metadataAsMutable);
        BOOL success = CGImageDestinationFinalize(destination);
        if(!success)
        {
            dest_data = [pngData mutableCopy];
        }
    }
    
    if(!destination)
    {
        CFRelease(destination);
    }
    
    CFRelease(source);
    
    return dest_data;
}

#pragma getImagedataPhotoLibrary
-(NSMutableData *)getImagedataPhotoLibrary:(NSDictionary *)pImgDictionary andImage:(UIImage *)pImage
{
    NSData* data = UIImagePNGRepresentation(pImage);
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    NSMutableDictionary *metadataAsMutable = [pImgDictionary mutableCopy];
    
    CFStringRef UTI = CGImageSourceGetType(source);
    
    NSMutableData *dest_data = [NSMutableData data];
    
    //For Mutabledata
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data, UTI, 1, NULL);
    
    if(!destination)
        dest_data = [data mutableCopy];
    else
    {
        CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef) metadataAsMutable);
        BOOL success = CGImageDestinationFinalize(destination);
        if(!success)
            dest_data = [data mutableCopy];
    }
    if(destination)
        CFRelease(destination);
    
    CFRelease(source);
    
    return dest_data;
}
/////////////////////
//Facebook methodes//
/////////////////////

//loginButton
-(IBAction)loginToFB
{
    [self showLoginView];
}

//loginView weergeven
-(void)showLoginView
{
    UIViewController *topViewController = [self.navigationController topViewController];
    
    UIViewController* loginViewController =
    [[CameraViewController alloc]init];
    [topViewController presentViewController:loginViewController animated:YES completion:NULL];
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.cameraButton.enabled = YES;
    }
    geocoder = [[CLGeocoder alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate        = self;  //SET YOUR DELEGATE HERE
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //SET THIS TO SPECIFY THE ACCURACY
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end