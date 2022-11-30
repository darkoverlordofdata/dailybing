#import <Cocoa/Cocoa.h>
#import "Window.h"

@implementation Window
- (instancetype)init {

  pictureBox1 = [[[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 240, 135)] autorelease];
  pictureBox2 = [[[NSImageView alloc] initWithFrame:NSMakeRect(240, 0, 240, 135)] autorelease];

  [super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
  [self setTitle:@"Bing Picture Of the Day"];
  [[self contentView] addSubview:pictureBox1];
  [[self contentView] addSubview:pictureBox2];
  [self setIsVisible:YES];

  NSURL *url1 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.RedPlanetDay_EN-US9693219784_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url2 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.HeronGiving_EN-US9774285216_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];

  NSImage *img1 = [[NSImage alloc] initWithContentsOfURL:url1];
  NSImage *img2 = [[NSImage alloc] initWithContentsOfURL:url2];

  [pictureBox1 setImage:img1];
  [pictureBox2 setImage:img2];

  return self;
}

- (BOOL)windowShouldClose:(id)sender {
  [NSApp terminate:sender];
  return YES;
}


@end

