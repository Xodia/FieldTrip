//
//  FTMainViewController.m
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 15/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "FTMainViewController.h"
#import "AFJSONRequestOperation.h"
#import "MBProgressHUD.h"
#import "FTFirstViewController.h"
#import "FTStudent.h"
#import "FTTeacherSingleton.h"

@interface FTMainViewController ()

@end


@implementation FTMainViewController

@synthesize fieldTripID, checkin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
   	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString: @"check"])
    {
        // to do  -> Request to server to fetch infos
    }
}

- (IBAction) checkID:(id)sender
{
    MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo: self.view  animated:YES];
    hud.labelText = @"Fetching FieldTrip ...";

   
    if ([fieldTripID.text isEqualToString: @""])
    {
        [hud hide: YES];
        return;
    }
    
   AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: [NSString stringWithFormat: @"http://ks3367383.kimsufi.com:3000/trips.json?code_id=%@", fieldTripID.text]]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                        {
                                            NSLog(@"JSON : %@", JSON);
 
                                            NSMutableArray *a  = [[NSMutableArray alloc] init];
                                     
                                            if ([JSON isKindOfClass: [NSArray class]])
                                            {
                                                NSDictionary *d = [JSON objectAtIndex: 0];
                                                [[FTTeacherSingleton sharedInstance] setMemberID: [d objectForKey: @"teacher_id"]];
                                                [[FTTeacherSingleton sharedInstance] setTripID:[d objectForKey: @"id"]];

                                                AFJSONRequestOperation *ope = [AFJSONRequestOperation JSONRequestOperationWithRequest:[[NSURLRequest alloc] initWithURL: [NSURL URLWithString: [NSString stringWithFormat: @"http://ks3367383.kimsufi.com:3000/members.json?trip_id=%@", [[FTTeacherSingleton sharedInstance] tripID]]]] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                    
                                                    
                                                    if ([JSON isKindOfClass: [NSArray class]])
                                                    {
                                                        if ([JSON count] == 0)
                                                        {
                                                            [hud hide: YES afterDelay: 2];
                                                            return;
                                                        }
                                                        for (NSDictionary *s in JSON)
                                                        {
                                                            FTStudent *b = [[FTStudent alloc] initWithDictionary: s];
                                                            [a addObject: b];
                                                        }
                                                        [[FTTeacherSingleton sharedInstance] setStudentList: a];
                                                    }
                                                    
                                                    [hud hide: YES];
                                                    
                                                    FTFirstViewController *v = [self.storyboard instantiateViewControllerWithIdentifier: @"tabbarcontroller"];
                                                    [self presentViewController: v animated: YES completion:^{
                                                        
                                                    }];
                                                

                                                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                    
                                                }];
                                                [ope start];
                                            }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {

    }];
    
    [operation start];
    //[self performSegueWithIdentifier: @"check" sender: self];
    
  
}

#pragma UITextfieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
