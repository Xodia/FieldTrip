//
//  XTUtils.m
//  XeeTourizm
//
//  Created by Morgan Collino on 01/09/13.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "XTUtils.h"

@implementation XTUtils

+ (double) distanceFromFirstCoordinate:(CLLocationCoordinate2D)coord1 toSecondCoordinate:(CLLocationCoordinate2D)coord2
{
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude: coord1.latitude longitude: coord1.longitude];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude: coord2.latitude longitude: coord2.longitude];
    CLLocationDistance meters = [location1 distanceFromLocation: location2];
    return meters;
}

@end
