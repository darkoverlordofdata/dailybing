/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "ImageContainer.h"

#define NUM_PICS 8

@implementation ImageContainer {
    NSMutableData *_responseData;
    NSMutableArray *_imageView; 
}

@synthesize parent = _parent;


- (instancetype)initWithParent: (ImageWindow*) parent
{
    _parent = parent;

    NSString *bingUrl = [NSString stringWithFormat:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=%i&mkt=en-US", NUM_PICS];
    NSURL *url = [NSURL URLWithString:bingUrl]; 
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:60];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    return self;

}

//============================================================================
#pragma mark - NSURLConnectionDelegate
//============================================================================

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [_responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"%@", error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *jsonErr = [[NSError alloc] init]; 

    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&jsonErr];

    NSArray<NSDictionary *> *images = [json valueForKey:@"images"];

    _imageView = [NSMutableArray arrayWithCapacity:NUM_PICS];
    for(int i = 0; i<NUM_PICS; i++){
        _imageView[i] = [[ImagePanel alloc] initWithIndex: i data:[images objectAtIndex: i]];
        [[_parent contentView] addSubview:_imageView[i]];
    }



}



@end