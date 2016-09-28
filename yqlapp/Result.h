//
//  Result.h
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (nonatomic, strong) NSString *rTitle, *rAddress;
@property (nonatomic, assign) double rLatitude, rLongitude;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
