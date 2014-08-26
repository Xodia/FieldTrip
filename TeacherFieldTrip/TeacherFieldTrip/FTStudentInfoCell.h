//
//  FTStudentInfoCell.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTStudentInfoCell : UITableViewCell
{
    UILabel *studentId;
    UIImageView *imageView; // will see
    UIImageView *rightImage;
}

@property (nonatomic, retain) IBOutlet UILabel *studentId;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIImageView *rightImage;


@end
