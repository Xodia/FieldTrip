//
//  FTMessageViewController.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"
@class FTStudent;

@interface FTMessageViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (nonatomic, retain) FTStudent *student;

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *timestamps;
@property (strong, nonatomic) NSMutableArray *subtitles;
@property (strong, nonatomic) NSDictionary *avatars;

@end
