//
//  Downloader.h
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloaderDelegate <NSObject>

-(void) didDownloadData:(NSArray *)downloadArray;
-(void) didFailWithErrr:(NSString *)strErr;

@end

@interface Downloader : NSObject

@property (nonatomic, weak) id<DownloaderDelegate> delegate;


-(void) downloadDataForString:(NSString *)str;

@end
