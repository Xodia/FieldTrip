//
//  FTStudent.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTStudent.h"
#import "XTTry.h"

@implementation FTStudent

@synthesize location, hasChecked, studentID;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
   if (self = [super init])
   {
       location = CLLocationCoordinate2DMake([XTTry tryGettingDouble: dictionary forKey: @"lat"], [XTTry tryGettingDouble: dictionary forKey: @"lon"]);
       hasChecked = [[XTTry tryGettingNumber: dictionary forKey: @"checked"] intValue] == 0 ? NO : YES;
       studentID = [XTTry tryGettingString: dictionary forKey: @"studentID"];
   }
    return  self;
}

@end
