#import <Cocoa/Cocoa.h>


@interface Window : NSWindow {
  NSImageView* pictureBox1;
  NSImageView* pictureBox2;
}
- (instancetype)init;
- (BOOL)windowShouldClose:(id)sender;

@end
