//
//  CustomAnnotationView.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "MapAnnotation.h"

@implementation CustomAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) {
        MapAnnotation *ann = annotation;
        
        if(ann.isReal){
            self.image = [UIImage imageNamed:@"real.png"];
        } else {
            self.image = [UIImage imageNamed:@"photo.jpg"];
        }
        self.enabled = YES;
        self.canShowCallout = YES;
        
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        self.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo.jpg"]];
        
    }
    return self;
}

@end
