//
//  FTNotification.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTNotification.h"
#import "XTTry.h"

@implementation FTNotification

@synthesize text, rate;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    if (self = [super init])
    {
        text = [XTTry tryGettingString: dictionary forKey: @"text"];
        rate = [XTTry tryGettingNumber: dictionary forKey: @"rate"].intValue;
    }
    return  self;
}
@end
