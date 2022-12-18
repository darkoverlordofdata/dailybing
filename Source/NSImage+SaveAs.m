/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import "NSImage+SaveAs.h"

//https://stackoverflow.com/questions/3038820/how-to-save-a-nsimage-as-a-new-file

@implementation NSImage(saveAsJpegWithName)

- (void) saveAsJpegWithName:(NSString*) fileName
{
    // Cache the reduced image
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];        
}
@end


@implementation NSImage(saveAsPngWithName)
- (void) saveAsPngWithName:(NSString*) fileName
{//
    // Cache the reduced image
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];        
}

@end

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
