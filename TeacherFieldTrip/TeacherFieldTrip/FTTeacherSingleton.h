//
//  FTTeacherSingleton.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FTTeacherSingleton : NSObject <CLLocationManagerDelegate>
{
    NSMutableArray *studentList;
    CLLocationCoordinate2D location;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) NSMutableArray *studentList;
@property (nonatomic) CLLocationCoordinate2D location;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString *tripID;
@property (nonatomic, copy) NSString *memberID;
@property (nonatomic, copy) NSString *codeID;
@property (nonatomic) float perimeter;
@property (nonatomic) float radius;

+ (instancetype) sharedInstance;
- (NSArray *) refreshStudentsInformations: (UIView *)view;
@end
