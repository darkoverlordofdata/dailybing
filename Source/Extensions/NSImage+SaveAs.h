/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>


@interface NSImage(saveAsJpegWithName)
- (void) saveAsJpegWithName:(NSString*) fileName;
@end

@interface NSImage(saveAsPngWithName)
- (void) saveAsPngWithName:(NSString*) fileName;
@end

