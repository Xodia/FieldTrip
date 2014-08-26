//
//  FTNotification.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTNotification : NSObject
{
    NSString *text;
    int rate; // 1 = minor 2 = medium 3 = HUUUUUUUUUGE warn
}
- (instancetype) initWithDictionary: (NSDictionary *) dictionary;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) int rate;

@end
