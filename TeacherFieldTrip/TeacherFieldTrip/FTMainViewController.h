//
//  FTMainViewController.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTMainViewController : UIViewController <UITextFieldDelegate>
{
    UIButton *checkin;
    UITextField *fieldTripID;
}

@property (nonatomic, retain) IBOutlet UIButton *checkin;
@property (nonatomic, retain) IBOutlet UITextField *fieldTripID;

@end
