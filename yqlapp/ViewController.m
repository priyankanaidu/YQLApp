//
//  ViewController.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "ViewController.h"
#import "ResultsTableViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *whatField;
@property (weak, nonatomic) IBOutlet UITextField *whereField;

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLGeocoder *coder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"%@",[locations firstObject]);
    [self.manager stopUpdatingLocation];

    self.coder = [[CLGeocoder alloc] init];
    
    [self.coder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *myPlace = [placemarks firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.whereField.text = myPlace.postalCode;
        });
        
    }];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status  {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.manager startUpdatingLocation];
    } else {
        self.whereField.text = @"Please go to setting sna sdjbfjshd fjsdgf ";
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ResultsTableViewController *results = segue.destinationViewController;
    results.whatText = self.whatField.text;
    results.whereText = self.whereField.text;
    
    
    
}

- (IBAction)getCurrentLocation:(id)sender {
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        [self.manager requestWhenInUseAuthorization];
        
    } else {
        [self.manager startUpdatingLocation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
