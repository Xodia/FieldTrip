//
//  FTSecondViewController.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTSecondViewController.h"
#import "FTTeacherSingleton.h"
#import "FTStudent.h"
#import "FTStudentAnnotation.h"
#import "FTMessageViewController.h"

@interface FTSecondViewController ()
{
    MKCircle *circle;
    NSMutableArray *annotions;
    NSTimer *t;
}
@end

@implementation FTSecondViewController

@synthesize mapView, refresh;

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.title = @"Map";

    t = [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    [t invalidate];
}

- (void) targetMethod: (id) sender
{
    NSLog(@"MAP !");
    [self pushRefresh];
}


- (void) pushRefresh
{
    if (circle)
    {
        [mapView removeOverlay: circle];
        circle = nil;
    }
    
    circle = [MKCircle circleWithCenterCoordinate: [[FTTeacherSingleton sharedInstance] location] radius: 10];
    
    [[FTTeacherSingleton sharedInstance] setRadius: circle.radius];
    [mapView addOverlay:circle];
    
    // refresh location;
    
    if (annotions)
    {
        [mapView removeAnnotations: annotions];
        [annotions removeAllObjects];
    }
    else
        annotions = [[NSMutableArray alloc] init];
    
    for (FTStudent *s in [[FTTeacherSingleton sharedInstance] studentList])
    {
        FTStudentAnnotation *a = [[FTStudentAnnotation alloc] initWithCoordinates: s.location placeName: [NSString stringWithFormat: @"%@ %@", s.lastname.uppercaseString, s.firstname] description: s.studentID forStudent: s];
        
        [mapView addAnnotation: a];
        [annotions addObject: a];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *r = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action: @selector(pushRefresh)];
    self.navigationItem.rightBarButtonItem = r;
    
    CLLocationCoordinate2D location = [FTTeacherSingleton sharedInstance].location;
    
    MKCoordinateRegion region;
    region.center = location;
    [mapView setRegion: region];
    
    circle = nil;
    circle = [MKCircle circleWithCenterCoordinate: [[FTTeacherSingleton sharedInstance] location] radius: 10];
    [[FTTeacherSingleton sharedInstance] setRadius: circle.radius];

    [mapView addOverlay:circle];
    

    annotions = [[NSMutableArray alloc] init];
    
    for (FTStudent *s in [[FTTeacherSingleton sharedInstance] studentList])
    {
        FTStudentAnnotation *a = [[FTStudentAnnotation alloc] initWithCoordinates: s.location placeName: [NSString stringWithFormat: @"%@ %@", s.lastname.uppercaseString, s.firstname] description: s.studentID forStudent: s];
        
        
        [mapView addAnnotation: a];
        
        //MKAnnotationView *v = [[MKAnnotationView alloc] initWithAnnotation: a reuseIdentifier: @"IDENT"];
        //mapView add
        [annotions addObject: a];
    }
// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showMessageView : (id) sender
{
    UIButton *b = (UIButton *) sender;
    FTMessageViewController  *v = [[FTMessageViewController alloc] init];
    v.student = [[[FTTeacherSingleton sharedInstance] studentList] objectAtIndex: b.tag];

    [self.navigationController pushViewController: v animated: YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{    
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"];
    
    if (annotation != mapView.userLocation)
    {
        view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
        if(nil == view) {
            view = [[MKPinAnnotationView alloc]
                     initWithAnnotation:annotation reuseIdentifier:@"identifier"];
        }
        
        FTStudentAnnotation *c = annotation;
        
        view.enabled = YES;
        view.canShowCallout = YES;
        view.multipleTouchEnabled = NO;
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        b.tag = [[[FTTeacherSingleton sharedInstance] studentList] indexOfObject: c.student];
        [b addTarget: self action:@selector(showMessageView:) forControlEvents: UIControlEventTouchUpInside];
        
        view.rightCalloutAccessoryView = b;
    }
    else
        view = nil;
    return view;
}


@end
