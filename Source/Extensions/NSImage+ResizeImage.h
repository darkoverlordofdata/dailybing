/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>


@interface NSImage(resizeImage)
- (NSImage*)resizeImage:(NSImage*)input by:(CGFloat)factor;
@end

