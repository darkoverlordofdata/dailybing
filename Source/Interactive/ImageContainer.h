/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "ImageContainer.h"
#import "ImageWindow.h"

@class ImageWindow;


/**
 * Class ImageFrame
 * Fetch images from https://bing.wallpaper.pics
 *
 */
@interface ImageContainer : NSObject<NSURLConnectionDelegate> 

@property (strong, nonatomic) ImageWindow *parent;

/**
 * Initialze and return a ImageContainer object
 */
- (instancetype)initWithParent: (ImageWindow*) parent;

#pragma mark - NSURLConnectionDelegate
/**
 * connection:didReceiveResponse
 */
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response;

/**
 * connection:didReceiveData
 */
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data;

/**
 * connection:didFailWithError
 */
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;

/**
 * connectionDidFinishLoading
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end