#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>

@interface NSImage (ProportionalScaling)
{
}
- (NSImage*)imageByScalingProportionallyToSize:(NSSize)targetSize;
@end
