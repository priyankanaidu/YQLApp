//
//  Result.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "Result.h"

@implementation Result

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.rTitle = [dict objectForKey:@"Title"];
        self.rAddress = [NSString stringWithFormat:@"%@, %@ - %@",[dict objectForKey:@"Address"],[dict objectForKey:@"City"],[dict objectForKey:@"State"]];
        self.rLatitude = [[dict objectForKey:@"Latitude"] doubleValue];
        self.rLongitude = [[dict objectForKey:@"Longitude"] doubleValue];
    }
    return self;
}

@end
