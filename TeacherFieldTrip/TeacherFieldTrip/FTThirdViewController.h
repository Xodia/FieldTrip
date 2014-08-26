//
//  FTThirdViewController.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTThirdViewController : UITableViewController
{
    NSMutableArray *notificationsList;
    UIButton *refresh;
}

@property (nonatomic, retain) NSMutableArray *notificationsList;
@property (nonatomic, retain) IBOutlet UIButton *refresh;

@end
