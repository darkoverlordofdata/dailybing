/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>
#import "ImagePanel.h"
#import "ImageContainer.h"
#import "../AppDelegate.h"

@class ImagePanel;
@class ImageContainer;
@class AppDelegate;

/**
 * Class ImageWindow
 * Main window for Interactive/DownloadBing
 *
 */
@interface ImageWindow : NSWindow ;

/**
 * Initialze and return a DBWindow object
 */
// - (instancetype) init;
- (instancetype)initWithParent: (AppDelegate*) parent;

/**
 * Terminate application and return YES
 */
- (BOOL) windowShouldClose:(id)sender;



@end
