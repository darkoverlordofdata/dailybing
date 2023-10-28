#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>

@interface BackView : NSView

@property (nonatomic) CGFloat radius;
- (void)drawRect:(NSRect)dirtyRect;
@end

