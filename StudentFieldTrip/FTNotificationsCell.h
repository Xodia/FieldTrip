//
//  FTNotificationsCell.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTNotificationsCell : UITableViewCell
{
    UILabel *warning;
    UIImageView *imageView; // will see
    UIImageView *rightImage;
}

@property (nonatomic, retain) IBOutlet UILabel *warning;
@property (nonatomic, retain) IBOutlet UIImageView *rightImage;


@end
