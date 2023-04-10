/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>

@class DBWindow;


@interface DBDataIndex : NSObject<NSURLConnectionDelegate> {
    NSMutableData *responseData;
    NSMutableArray *imageView; //DBImageView
}

@property (strong, nonatomic) DBWindow *parent;

- (instancetype)initWithParent: (DBWindow*) parent;

//  NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data;
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end