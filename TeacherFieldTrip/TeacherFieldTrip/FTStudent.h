//
//  FTStudent.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FTStudent : NSObject
{
    BOOL hasChecked;
    NSString *studentID, *_id, *firstname, *lastname;
    CLLocationCoordinate2D location;
}

- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

@property (nonatomic) BOOL hasChecked;
@property (nonatomic, copy) NSString *studentID;
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic) CLLocationCoordinate2D location;

@end
