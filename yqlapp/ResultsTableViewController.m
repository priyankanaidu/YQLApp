//
//  ResultsTableViewController.m
//  YQLApp
//
//  Created by Priyanka Naidu on 8/7/16.
//  Copyright © 2016 Priyanka Naidu. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "CustomLoadingTableViewCell.h"
#import "MapViewController.h"
#import "Downloader.h"
#import "Result.h"

@interface ResultsTableViewController () <DownloaderDelegate> {//<NSURLConnectionDataDelegate> {
//    NSMutableData *bucketData;
    NSArray *arrayOfResults;
}

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSString *str = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20local.search%%20where%%20zip%%3D%%27%@%%27%%20and%%20query%%3D%%27%@%%27&format=json&callback=",self.whereText, self.whatText];
    
    Downloader *down = [[Downloader alloc] init];
    down.delegate = self;
    [down downloadDataForString:str];
    
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.title = self.whatText;
    
    
        
    
}


-(void) didDownloadData:(NSArray *)downloadArray{
    arrayOfResults = downloadArray;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

    
}

-(void) didFailWithErrr:(NSString *)strErr{
    
}
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    
//    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
//    if(resp.statusCode == 200){
//        bucketData = [[NSMutableData alloc] init];
//    }
//    
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    
//    [bucketData appendData:data];
//    
//    
//}
//
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    
//    NSError *error;
//    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:bucketData options:NSJSONReadingMutableContainers error:&error];
//    if(!error){
//        arrayOfResults = [[[dictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"];
//        [self.tableView reloadData];
//    } else {
//        NSLog(@"OOPS");
//    }
//    
//}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(arrayOfResults.count == 0){
        return 1;
    }
    return arrayOfResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(arrayOfResults.count == 0){
        CustomLoadingTableViewCell *loadingcell = [tableView dequeueReusableCellWithIdentifier:@"loading" forIndexPath:indexPath];
        [loadingcell.laodingActivity startAnimating];
        return loadingcell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Result *res = [arrayOfResults objectAtIndex:indexPath.row];
    cell.textLabel.text = res.rTitle;
    cell.detailTextLabel.text = res.rAddress;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapViewController *map = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    map.result = [arrayOfResults objectAtIndex:indexPath.row];
}


@end
