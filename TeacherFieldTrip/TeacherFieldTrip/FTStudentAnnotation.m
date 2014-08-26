//
//  FTStudentAnnotation.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTStudentAnnotation.h"
#import "FTStudent.h"

@implementation FTStudentAnnotation

@synthesize coordinate, subtitle, title, student;

- (id) initWithCoordinates:(CLLocationCoordinate2D)location placeName:(NSString *)placeName description:(NSString *)description forStudent: (FTStudent *) stu
{
    if (self = [super init])
    {
        title = placeName;
        subtitle = description;
        coordinate = location;
        student = stu;
    }
    return  self;
}

@end
