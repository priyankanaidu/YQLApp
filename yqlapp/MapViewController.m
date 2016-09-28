//
//  MapViewController.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"
#import "CustomAnnotationView.h"

@interface MapViewController () <UITextFieldDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLGeocoder *coder;

@end

@implementation MapViewController


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [mapView setRegion:MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    CustomAnnotationView *cv = view;
    MapAnnotation *ann = cv.annotation;
    NSLog(@"HERE - %f",ann.coordinate.latitude);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.result.rTitle;
    
    
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = self.result.rLatitude;//38.908771
//    coordinate.longitude = self.result.rLongitude;//-76.99783
//    
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.02;
//    span.longitudeDelta = 0.02;
//    
//    MKCoordinateRegion region;
//    region.center = coordinate;
//    region.span = span;
    
    
//    [self.myMapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.result.rLatitude, self.result.rLongitude), MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
    
    //MKAnnotation
    MapAnnotation *ann = [[MapAnnotation alloc] init];
    ann.coordinate = CLLocationCoordinate2DMake(self.result.rLatitude, self.result.rLongitude);
    ann.title = self.result.rTitle;
    ann.subtitle = self.result.rAddress;
    ann.isReal = YES;
    [self.myMapView addAnnotation:ann];
    
    
    
    //39.0021119,-76.8802822
    //39.004180, -76.875272
    //39.004196, -76.879027
    //39.000611, -76.878705
    
    CLLocationCoordinate2D arr[4] = {{39.0021119,-76.8802822},{39.004180, -76.875272},{39.000611, -76.878705},{39.004196, -76.879027}};
    
    MKPolyline *line = [MKPolyline polylineWithCoordinates:arr count:4];
      [self.myMapView addOverlay:line];
//    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:arr count:4];
//    [self.myMapView addOverlay:polygon];
    
    
//    MKCircle *circle = [MKCircle circleWithCenterCoordinate:ann.coordinate radius:300];
//    [self.myMapView addOverlay:circle];
    
//    MapAnnotation *ann2 = [[MapAnnotation alloc] init];
//    ann2.coordinate = CLLocationCoordinate2DMake(self.result.rLatitude+0.001, self.result.rLongitude+0.001);
//    ann2.title = self.result.rTitle;
//    ann2.subtitle = self.result.rAddress;
//    ann2.isReal = NO;
//    [self.myMapView addAnnotation:ann2];
//    
//    
//    MapAnnotation *ann3 = [[MapAnnotation alloc] init];
//    ann3.coordinate = CLLocationCoordinate2DMake(self.result.rLatitude-0.001, self.result.rLongitude-0.001);
//    ann3.title = self.result.rTitle;
//    ann3.subtitle = self.result.rAddress;
//    ann3.isReal = YES;
//    [self.myMapView addAnnotation:ann3];
    
}



- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass: [MKUserLocation class]]){
        return nil;
    }
    
    CustomAnnotationView *custom = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    
    
    
//    MKPinAnnotationView *annView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
//    
//    if(annView == nil){
//        annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
//    }
//    
//    annView.pinTintColor = [UIColor blackColor];
    
    return custom;
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    MKPolylineRenderer *poly = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    poly.strokeColor = [UIColor blackColor];
    poly.lineWidth = 2.0;
    return poly;
    
    
//    MKPolygonRenderer *poly = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
//    poly.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.4];
//    poly.strokeColor = [UIColor blackColor];
//    poly.lineWidth = 2.0;
//    return poly;
    
//    MKCircleRenderer *cr = [[MKCircleRenderer alloc] initWithCircle:overlay];
//    cr.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.4];
//    cr.strokeColor = [UIColor blackColor];
//    cr.lineWidth = 2.0;
//    return cr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.coder = [[CLGeocoder alloc] init];
    [self.coder geocodeAddressString:self.textField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *pl = [placemarks lastObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MapAnnotation *ann = [[MapAnnotation alloc] init];
            ann.coordinate = pl.location.coordinate;
            ann.title = pl.name;
            ann.subtitle = pl.locality;
            ann.isReal = YES;
            [self.myMapView addAnnotation:ann];
            
            [self.myMapView setRegion:MKCoordinateRegionMake(pl.location.coordinate, MKCoordinateSpanMake(0.02, 0.02)) animated:YES];
            

        });
        
        
    }];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
