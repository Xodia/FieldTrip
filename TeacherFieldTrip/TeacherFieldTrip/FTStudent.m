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

@synthesize location, hasChecked, studentID, _id, firstname, lastname;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
   if (self = [super init])
   {
       location = CLLocationCoordinate2DMake([XTTry tryGettingDouble: dictionary forKey: @"lat"], [XTTry tryGettingDouble: dictionary forKey: @"lon"]);
       hasChecked = [[XTTry tryGettingNumber: dictionary forKey: @"checked"] intValue] == 0 ? NO : YES;
       studentID = [XTTry tryGettingString: dictionary forKey: @"studentID"];
       _id = [XTTry tryGettingString: dictionary forKey: @"id"];
       
       NSDictionary *d = [XTTry tryGettingDictionary: dictionary forKey: @"student"];
       
       lastname = [XTTry tryGettingString: d forKey: @"last_name"];
       firstname = [XTTry tryGettingString: d forKey: @"first_name"];
       
       NSArray *a = [XTTry tryGettingArray: dictionary forKey: @"geolocalizations"];
       NSDictionary *p = [a lastObject];
       if (p)
       {
           location = CLLocationCoordinate2DMake([XTTry tryGettingDouble: p forKey: @"latitude"], [XTTry tryGettingDouble: p forKey: @"longitude"]);
       }
   }
    return  self;
}

@end
