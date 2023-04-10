#import "BackView.h"

@implementation BackView

- (void)drawRect:(NSRect)dirtyRect {
  _radius = 10;
  NSRect rect = [self bounds];
  NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect
                                                       xRadius:self.radius
                                                       yRadius:self.radius];
  [path addClip];

  //  Cotton Cloth #faf4d3
  float rr = (float)0xfa / (float)255;
  float gg = (float)0xf4 / (float)255;
  float bb = (float)0xd3 / (float)255;

  [[NSColor colorWithDeviceRed:rr green:gg blue:bb alpha:0.6f] set];
  // [[NSColor cyanColor] set];
  NSRectFill(dirtyRect);

  [super drawRect:dirtyRect];
}

@end
