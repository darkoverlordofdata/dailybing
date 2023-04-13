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
    NSMutableData *responseData;

}

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *desc; //copyright
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *urlBase;
@property (strong, nonatomic) NSString *resourcePath;

- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data;
- (void)onSelectImage;

//  NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data;
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end