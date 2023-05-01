/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "ImageWindow.h"
#import "../Extensions/NSImage+SaveAs.h"
#import "../Extensions/NSImage+ResizeImage.h"

@class ImageWindow;

/**
 * Class ImagePanel
 * Displays images downloaded from https://bing.wallpaper.pics
 *
 */
@interface ImagePanel : NSImageView <NSURLConnectionDelegate> 


/**
 * Initialze and return a ImagePanel object
 */
- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data;
/**
 * Respond to image selected
 */
- (void)onSelectImage;

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