//
//  FTSecondViewController.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FTStudent.h"

@interface FTSecondViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView *mapView;
    UIButton *refresh;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIButton *refresh;

@end
