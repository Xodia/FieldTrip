//
//  FTTeacherSingleton.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "FTStudent.h"

@interface FTTeacherSingleton : NSObject <CLLocationManagerDelegate>
{
    CLLocationCoordinate2D location;
    CLLocationManager *locationManager;
    FTStudent *student;
    NSMutableArray *message;
}

@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, retain) FTStudent *student;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *message;
@property (nonatomic, copy) NSString *tripID;
@property (nonatomic, copy) NSString *memberID;
@property (nonatomic, copy) NSString *codeID;

+ (instancetype) sharedInstance;
@end
