//
//  FTThirdViewController.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTThirdViewController.h"
#import "FTStudent.h"
#import "FTNotificationsCell.h"
#import "FTNotification.h"
#import "FTTeacherSingleton.h"
#import "XTUtils.h"

@interface FTThirdViewController ()
{
    NSTimer *t;
    NSString *lastMissing;
}
@end

@implementation FTThirdViewController

@synthesize notificationsList, refresh;

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = NO;
    t = [NSTimer scheduledTimerWithTimeInterval:7.0
                                         target:self
                                       selector:@selector(targetMethod:)
                                       userInfo:nil
                                        repeats:YES];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    //[t invalidate];
}

- (void) createNotification: (FTStudent *) s
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate date];
    localNotification.alertBody = [NSString stringWithFormat: @"%@ %@: Student out of the zone !", s.lastname.uppercaseString, s.firstname];
    localNotification.alertAction = @"URGENT";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void) targetMethod: (id) sender
{
    NSLog(@"NOTIFICATIONS !");
    
    NSArray *ss = [[FTTeacherSingleton sharedInstance] studentList];
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray: notificationsList];
    
    for (FTStudent *s in ss)
    {
        double res =  [XTUtils distanceFromFirstCoordinate: s.location toSecondCoordinate: [[FTTeacherSingleton sharedInstance] location]];
        
        NSLog(@"RES: %f  > %f", res, [[FTTeacherSingleton sharedInstance] perimeter]);
        
        if (res > [[FTTeacherSingleton sharedInstance] perimeter] && res < 100000 && ![lastMissing isEqual: [NSString stringWithFormat: @"%@ %@", s.lastname.uppercaseString, s.firstname]])
        {
            [self createNotification: s];
             FTNotification  *a = [[FTNotification alloc] initWithDictionary: @{@"text" :[NSString stringWithFormat: @"%@ %@: Student out of the zone !", s.lastname.uppercaseString, s.firstname], @"rate" : @3}];
            [tmp addObject: a];
            lastMissing = [NSString stringWithFormat: @"%@ %@", s.lastname.uppercaseString, s.firstname];
        }
    }
    
    notificationsList = tmp;
    tmp = nil;
    [self.tableView reloadData];
   
    
    
    [[FTTeacherSingleton sharedInstance] perimeter];
    
    /*AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @""]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     
     NSLog(@"JSON : %@", JSON);
     
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
     
     }];*/
}

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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Notifications";

    UIBarButtonItem *r = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action: @selector(pushRefresh)];
    self.navigationItem.rightBarButtonItem = r;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    FTNotification  *a = [[FTNotification alloc] initWithDictionary: @{@"text" : @"999930410: Student out of the zone !", @"rate" : @3}];
    FTNotification  *b = [[FTNotification alloc] initWithDictionary: @{@"text" : @"999930411: Student want to go to the restroom !", @"rate" : @1}];
    FTNotification  *c = [[FTNotification alloc] initWithDictionary: @{@"text" : @"999930412: Student is feeling sick !", @"rate" : @2}];
    
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    [tmp addObject: a];
    [tmp addObject: b];
    [tmp addObject: c];
    notificationsList = tmp;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notificationsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FTNotificationsCell";
    FTNotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FTNotification *n = [notificationsList objectAtIndex: indexPath.row];
    
    cell.warning.text = n.text;
    cell.rightImage.image = n.rate == 3 ? [UIImage imageNamed: @"highwarning.png"] : n.rate == 2 ? [UIImage imageNamed: @"middwarning.png"] : [UIImage imageNamed: @"littlewarning.png"];

    cell.warning.textColor = n.rate == 3 ? [UIColor whiteColor] : n.rate == 2 ? [UIColor whiteColor] : [UIColor blackColor];
// change background color by rate TOO ! /!\
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
        [notificationsList removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


- (IBAction)refreshTouched:(id)sender
{
    // Do refresh
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTNotification *n = [notificationsList objectAtIndex: indexPath.row];
    NSLog(@"%d", n.rate);
    
    if (n.rate == 3)
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green: 0 blue: 0 alpha: 0.4];
    if (n.rate == 2)
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green: 69/250.0 blue: 0 alpha: 0.4];
    if (n.rate == 1)
        cell.backgroundColor = [UIColor colorWithRed:255/255.0 green: 200/250.0 blue: 0 alpha: 0.4];
    
}

@end
