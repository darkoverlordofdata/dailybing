#import <Cocoa/Cocoa.h>

@interface BackView : NSView
{
  CGFloat _radius;
}
@property (nonatomic) CGFloat radius;
- (void)drawRect:(NSRect)dirtyRect;
@end

