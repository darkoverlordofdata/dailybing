/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import "NSImage+ResizeImage.h"


@implementation NSImage(resizeImage)
-(NSImage*)resizeImage:(NSImage*)input by:(CGFloat)factor
{    
    NSSize size = NSZeroSize;      
    size.width = input.size.width*factor;
    size.height = input.size.height*factor; 

    NSImage *ret = [[NSImage alloc] initWithSize:size];
    [ret lockFocus];
    NSAffineTransform *transform = [NSAffineTransform transform];
    [transform scaleBy:factor];  
    [transform concat]; 
    [input drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];    
    [ret unlockFocus];        

    return [ret autorelease];
}
@end
