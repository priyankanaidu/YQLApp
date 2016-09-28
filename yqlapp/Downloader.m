//
//  Downloader.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "Downloader.h"
#import "Result.h"

@interface Downloader () {
    NSMutableArray *arrayOfResults;
}

@end

@implementation Downloader

-(void) downloadDataForString:(NSString *)str {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         
                                         sleep(10);
                                         
                                         if(!error){
                                             NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
                                             if(resp.statusCode == 200){
                                                 if(data){
                                                     
                                                     NSError *errorJson;
                                                     NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
                                                     if(!errorJson){
                                                         if([[[dictionary objectForKey:@"query"] objectForKey:@"results"] isKindOfClass:[NSNull class]]){
                                                             NSLog(@"OOPS");
                                                         } else {
                                                             //check if query,results, Result, Items
                                                             arrayOfResults = [[NSMutableArray alloc] init];
                                                             
                                                             if([[[[dictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"] isKindOfClass:[NSArray class]]){
                                                                 
                                                                 for(NSDictionary *dict in [[[dictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"]){
                                                                     Result *result = [[Result alloc] initWithDictionary:dict];
                                                                     [arrayOfResults addObject:result];
                                                                     
                                                                 }
                                                             } else {
                                                                 Result *result = [[Result alloc] initWithDictionary:[[[dictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"]];
                                                                 [arrayOfResults addObject:result];
                                                             }
                                                             
                                                             if([self.delegate respondsToSelector:@selector(didDownloadData:)]){
                                                                 [self.delegate didDownloadData:arrayOfResults];
                                                             }
//                                                             dispatch_async(dispatch_get_main_queue(), ^{
//                                                                 [self.tableView reloadData];
//                                                                 
//                                                             });
                                                             
                                                             
                                                         }
                                                         
                                                     } else {
                                                         //OOPS
                                                     }
                                                 } else {
                                                     //OOPS Dala Nil
                                                 }
                                             } else {
                                                 //OOPS 404
                                             }
                                         } else {
                                             //OOPS error
                                         }
                                         
                                     }] resume];

}

@end
