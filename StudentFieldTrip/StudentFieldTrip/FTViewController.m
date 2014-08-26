//
//  FTViewController.m
//  StudentFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTViewController.h"
#import "MBProgressHUD.h"
#import "AFJSONRequestOperation.h"
#import "FTTeacherSingleton.h"

@interface FTViewController ()

@end

@implementation FTViewController

@synthesize studentID, tripID, checkin;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) pushCheckin:(id)sender
{
    MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo: self.view  animated:YES];
    hud.labelText = @"Fetching FieldTrip ...";
    
    
    if ([studentID.text isEqualToString: @""] && [tripID.text isEqualToString: @""])
    {
        [hud hide: YES];
        return;
    }
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: [NSString stringWithFormat: @"http://ks3367383.kimsufi.com:3000/trips.json?code_id=%@&student_id=%@", tripID.text, studentID.text]]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                         {
                                             NSLog(@"JSON : %@", JSON);
                                             
                                             if ([JSON isKindOfClass: [NSDictionary class]])
                                             {
                                                 NSDictionary *d = JSON;
                                                 [[FTTeacherSingleton sharedInstance] setMemberID: [d objectForKey: @"id"]];
                                                 [[FTTeacherSingleton sharedInstance] setTripID:[d objectForKey: @"trip_id"]];
                                                 
                                                 UINavigationController *n = [self.storyboard instantiateViewControllerWithIdentifier: @"navcontroller"];
                                                 [self presentViewController: n animated:YES completion:^{
                                                     [hud hide: YES];
                                                 }];
                                             }
                                         }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                             [hud hide: YES];
                                             NSLog(@"JSON : %@", JSON);


                                         }];
    
    [operation start];
    //[self performSegueWithIdentifier: @"check" sender: self];
    

}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
