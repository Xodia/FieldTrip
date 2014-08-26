//
//  XTUtils.h
//  XeeTourizm
//
//  Created by Morgan Collino on 01/09/13.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface XTUtils : NSObject


// Get distance in meters from {lat,lon} coord1 and {lat,lon} coord2;
+ (double) distanceFromFirstCoordinate: (CLLocationCoordinate2D) coord1 toSecondCoordinate: (CLLocationCoordinate2D) coord2;

@end
