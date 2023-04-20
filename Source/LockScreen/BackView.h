#import <Cocoa/Cocoa.h>

@interface BackView : NSView

@property (nonatomic) CGFloat radius;
- (void)drawRect:(NSRect)dirtyRect;
@end

