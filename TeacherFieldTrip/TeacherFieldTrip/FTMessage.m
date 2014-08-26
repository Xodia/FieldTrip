//
//  FTMessage.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTMessage.h"
#import "XTTry.h"

@implementation FTMessage

@synthesize msg, date, fromMe;


- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    if (self = [super init])
    {
        msg = [XTTry tryGettingString: dictionary forKey: @"msg"];
        fromMe = [[XTTry tryGettingNumber: dictionary forKey: @"fromMe"] intValue] == 0 ? NO : YES;
        date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }
    return  self;
}
@end
