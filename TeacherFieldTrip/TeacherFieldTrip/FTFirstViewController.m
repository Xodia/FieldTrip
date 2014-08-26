//
//  FTFirstViewController.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTFirstViewController.h"
#import "FTStudentInfoCell.h"
#import "FTStudent.h"
#import "FTTeacherSingleton.h"

@interface FTFirstViewController ()

@end

@implementation FTFirstViewController

@synthesize studentsList, refresh;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) pushRefresh
{
    studentsList = [[FTTeacherSingleton sharedInstance] refreshStudentsInformations: self.view];
}

- (void) back: (id) sender
{
    [self dismissViewControllerAnimated: YES  completion:^{
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Students list";
    
    UIBarButtonItem *r = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action: @selector(pushRefresh)];
    
    UIBarButtonItem *l = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action: @selector(back:)];

    self.navigationItem.rightBarButtonItem = r;
    self.navigationItem.leftBarButtonItem = l;
    
    studentsList = [[FTTeacherSingleton sharedInstance] studentList];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = NO;
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [studentsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FTStudentInfoCell";
    FTStudentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FTStudent *s = [studentsList objectAtIndex: indexPath.row];
    
    cell.studentId.text = [NSString stringWithFormat: @"%@ %@", s.lastname.uppercaseString, s.firstname];
    cell.rightImage.image = s.hasChecked == YES ? [UIImage imageNamed: @"checked.png"] : [UIImage imageNamed: @"unchecked.png"];
    // Configure the cell...
    
    return cell;
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

- (IBAction)refreshTouched:(id)sender
{
    // Do refresh
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

@end
