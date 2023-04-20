/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "ImagePanel.h"
#import "ImageContainer.h"

@class ImagePanel;
@class ImageContainer;

/**
 * Class ImageWindow
 * Main window for Interactive/DownloadBing
 *
 */
@interface ImageWindow : NSWindow;

/**
 * Initialze and return a DBWindow object
 */
- (instancetype) init;
/**
 * Terminate application and return YES
 */
- (BOOL) windowShouldClose:(id)sender;



@end
