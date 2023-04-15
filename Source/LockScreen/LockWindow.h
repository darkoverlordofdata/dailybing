#import <Cocoa/Cocoa.h>
#import "../Extensions/NSImage+ProportionalScaling.h"
#import "BackView.h"
#import "../AppDelegate.h"

@class AppDelegate;

@interface LockWindow : NSWindow 
{
  NSImageView* _avatar;
  NSImageView* _wallpaperLocked;
  NSImageView* _wallpaperAuthorize;
  NSTimer* _timer;
  int _counter;
  NSString* _input;
  NSSecureTextField* _passcode;
  BackView* _backView;
  NSTextField* _userName;

  NSTextField* _title;
  NSTextField* _description;
  NSTextField* _copyright;
  NSTextField* _currentDate;
  NSTextField* _currentTime;
  NSTextField* _instructions;
}


- (instancetype)init;
// - (instancetype)initWithParent: (AppDelegate*) parent;
- (BOOL)windowShouldClose:(id)sender;
- (void)onTimerTick:(NSTimer*)timer;
- (void)onTimerQuit:(NSTimer*)timer;
- (void)updateTime;
- (void)setAppearance:(BOOL) locked;

@end

