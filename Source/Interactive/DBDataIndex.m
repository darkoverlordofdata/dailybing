/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBDataIndex.h"
#import "DBImageView.h"

#define NUM_PICS 8

@implementation DBDataIndex;

@synthesize parent = _parent;


- (instancetype)initWithParent: (DBWindow*) parent
{
    _parent = parent;

    NSString *bingUrl = [NSString stringWithFormat:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=%i&mkt=en-US", NUM_PICS];
    NSLog(@"%@", bingUrl);
    NSURL *url = [NSURL URLWithString:bingUrl]; 
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:60];


    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    return self;

}

//NSURLConnectionDelegate protocol
//============================================================================

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonErr = [[NSError alloc] init]; 

    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&jsonErr];

    NSArray *images = [json valueForKey:@"images"];

    imageView = [NSMutableArray arrayWithCapacity:NUM_PICS];
    for(int i = 0; i<NUM_PICS; i++){
        imageView[i] = [[DBImageView alloc] initWithIndex: i data:[images objectAtIndex: i]];
        [[_parent contentView] addSubview:imageView[i]];
    }



}



@end