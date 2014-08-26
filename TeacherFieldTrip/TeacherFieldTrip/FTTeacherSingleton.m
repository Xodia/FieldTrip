//
//  FTTeacherSingleton.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTTeacherSingleton.h"
#import "FTStudent.h"
#import "AFJSONRequestOperation.h"
#import "MBProgressHUD.h"

@implementation FTTeacherSingleton

@synthesize studentList, location, locationManager, tripID, memberID, codeID, perimeter, radius;


- (instancetype) init
{
    if (self = [super init])
    {
        location = CLLocationCoordinate2DMake(0, 0);
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        perimeter = 10;
        
        //tmp
        
       /* FTStudent *a = [[FTStudent alloc] initWithDictionary: @{@"studentID": @"999930410", @"checked": @1, @"lat": @34.019285, @"lon": @(-118.494295)}];
        FTStudent *b = [[FTStudent alloc] initWithDictionary: @{@"studentID": @"999930411", @"checked": @0, @"lat": @34.019289, @"lon": @(-118.494288)}];
        FTStudent *c = [[FTStudent alloc] initWithDictionary: @{@"studentID": @"999930412", @"checked": @1, @"lat": @34.019285, @"lon": @(-118.494292)}];
        
        
        studentList = [[NSMutableArray alloc] init];
        [studentList addObject: a];
        [studentList addObject: b];
        [studentList addObject: c];
*/
        
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(targetMethod:)
                                       userInfo:nil
                                        repeats:YES];
    
    }
    return self;
}

#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (location.latitude != [newLocation coordinate].latitude || location.longitude != [newLocation
    coordinate].longitude)
    {
        location = [newLocation coordinate];
        NSString *jsonRequest = @"geolocalization[id]=-1&geolocalization[longitude]=%f&geolocalization[latitude]=%f&geolocalization[member_id]=%d";
        
        jsonRequest = [NSString stringWithFormat:jsonRequest, location.longitude, location.latitude,memberID.intValue];
        NSURL *url = [NSURL URLWithString: @"http://ks3367383.kimsufi.com:3000/geolocalizations.json"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        NSLog(@"JSON: %@", jsonRequest);
        
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"json=%@",jsonRequest];
        
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
        }];
        [operation start];
        NSLog(@"New location : {%f,%f}", location.latitude, location.longitude);
    }
    
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static FTTeacherSingleton *sharedFoo;
    dispatch_once(&once, ^ {
        sharedFoo = [[FTTeacherSingleton alloc] init];
    });
    return sharedFoo;
} // There's no going back


- (NSArray *) refreshStudentsInformations: (UIView *)view
{
    // WS -> Get Informations Students
    // parse : JSON [ { student_id, url_img, ...} ]
    
    MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo: view  animated:YES];
    hud.labelText = @"Loading";
   /* AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @""]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"JSON : %@", JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];*/
    
    
    [hud hide: YES];
    
    return studentList;
}

- (void) targetMethod: (id) sender
{
    NSLog(@"REFRESH !");
    
    NSMutableArray *a = [[NSMutableArray alloc] init];
    
    AFJSONRequestOperation *ope = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: [NSString stringWithFormat: @"http://ks3367383.kimsufi.com:3000/members.json?trip_id=%@", [[FTTeacherSingleton sharedInstance] tripID]]]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        
        if ([JSON isKindOfClass: [NSArray class]])
        {
            if ([JSON count] == 0)
            {
                return;
            }
            for (NSDictionary *s in JSON)
            {
                FTStudent *b = [[FTStudent alloc] initWithDictionary: s];
                [a addObject: b];
            }
            [[FTTeacherSingleton sharedInstance] setStudentList: a];
        }
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    [ope start];
    
    /*AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @""]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     
        NSLog(@"JSON : %@", JSON);
     
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
     
    }];*/
}

@end
