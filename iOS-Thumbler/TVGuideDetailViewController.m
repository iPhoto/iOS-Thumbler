//
//  TVGuideDetailViewController.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 12/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "TVGuideDetailViewController.h"
#import "Programma.h"
#import "ProgramCell.h"

@interface TVGuideDetailViewController ()

@end

@implementation TVGuideDetailViewController

@synthesize _objectsB;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)initWithObjects:(NSMutableArray *)programmaObjects
//{
//    self = [super initWithNibName:@"TVGuideDetailViewController" bundle:nil];
//    if (self) {
//        _objectsB = [programmaObjects copy];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _objectsB.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProgramCell";
    
    ProgramCell *cell = (ProgramCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Programma *thisProgramma = [_objectsB objectAtIndex:indexPath.row];
    
    cell.lblTime.text = thisProgramma.tijd;
    cell.lblTitle.text = thisProgramma.titel;
    cell.lblDescription.text = thisProgramma.omschrijving;
    
    UIImage *ratingPic;
    if ([thisProgramma.rating isEqualToString:@"TV-PG"]) {
        ratingPic = [UIImage imageNamed:@"tvpg.jpg"];
    } else if ([thisProgramma.rating isEqualToString:@"TV-14"]) {
        ratingPic = [UIImage imageNamed:@"tv14.jpg"];
    } else {
        ratingPic = [UIImage imageNamed:@"tvy.jpg"];
    }
    
    cell.picRating.image = ratingPic;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ProgramCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Programma *thisProgramma = [_objectsB objectAtIndex:indexPath.row];
    if (thisProgramma.seen){
        //[cell setBackgroundColor:[UIColor grayColor]];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad.jpeg"]];
    }
    else
    {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good.jpg"]];
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Programma's";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
