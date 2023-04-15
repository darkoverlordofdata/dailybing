/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"
#import "../Extensions/NSImage+SaveAs.h"

@class DBWindow;


@interface DBImageView : NSImageView <NSURLConnectionDelegate> {
    NSString *_url;
    NSString *_desc;
    NSString *_title;
    NSString *_urlBase;
    NSMutableData *_responseData;
}


- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data;
- (void)onSelectImage;

//  NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data;
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end