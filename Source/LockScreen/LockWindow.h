#import <Cocoa/Cocoa.h>
#import "../Extensions/NSImage+ProportionalScaling.h"
#import "BackView.h"
#import "../AppDelegate.h"

@class AppDelegate;

@interface LockWindow : NSWindow 
{
  id  target;
  SEL action;
  NSImageView* avatar;
  NSImageView* wallpaperLocked;
  NSImageView* wallpaperAuthorize;
  NSTimer* timer;
  int counter;
  NSString* input;
  NSSecureTextField* passcode;
  BackView* backView;
  NSTextField* userName;

  NSTextField* title;
  NSTextField* description;
  NSTextField* copyright;
  NSTextField* currentDate;
  NSTextField* currentTime;
  NSTextField* instructions;
}


- (instancetype)init;
// - (instancetype)initWithParent: (AppDelegate*) parent;
- (BOOL)windowShouldClose:(id)sender;
- (void)onTimerTick:(NSTimer*)timer;
- (void)onTimerQuit:(NSTimer*)timer;
- (void)updateTime;
- (void)setAppearance:(BOOL) locked;

@end

