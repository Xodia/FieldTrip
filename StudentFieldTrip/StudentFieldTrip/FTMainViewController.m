//
//  FTMainViewController.m
//  StudentFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTMainViewController.h"
#import "FTNotificationsCell.h"
#import "FTMessageViewController.h"
#import "FTProblemsViewController.h"

@interface FTMainViewController ()
{
    NSMutableArray *notifs;
    NSTimer *t;
}
@end

@implementation FTMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) targetMethod: (id) sender
{
    // fetch notifs !
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    t = [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(targetMethod:)
                                       userInfo:nil
                                        repeats:YES];
    

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
    return [notifs count] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FTNotificationsCell.h
    UITableViewCell *cell;
    if (indexPath.row >= [notifs count])
    {
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (indexPath.row == notifs.count)
            cell.textLabel.text = @"Contact teacher";
        else
            cell.textLabel.text = @"Problems ?";
    }
    else
    {
        static NSString *CellIdentifier = @"FTNotificationsCell";
        FTNotificationsCell *c = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell = c;
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if (!(indexPath.row >= notifs.count))
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [notifs removeObjectAtIndex: indexPath.row];
        }
    }
  
}

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == notifs.count)
    {
        // messaging
        FTMessageViewController *v = [[FTMessageViewController alloc] init];
        [self.navigationController pushViewController: v animated: YES];

    }
    else if (indexPath.row == notifs.count + 1)
    {
        // problems ?
        FTProblemsViewController *v = [self.storyboard instantiateViewControllerWithIdentifier: @"FTProblemsViewController"];
        [self.navigationController pushViewController: v animated: YES];
    }
    else
    {
        
    }
}

@end
