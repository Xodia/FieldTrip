//
//  FTViewController.h
//  StudentFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTViewController : UIViewController <UITextFieldDelegate>
{
    UIButton *checkin;
    UITextField *tripID, *studentID;
}
@property (nonatomic, retain) IBOutlet UIButton *checkin;
@property (nonatomic, retain) IBOutlet UITextField *tripID;
@property (nonatomic, retain) IBOutlet UITextField *studentID;
@end
