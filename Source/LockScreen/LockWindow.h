#import <Cocoa/Cocoa.h>
#import "../Extensions/NSImage+ProportionalScaling.h"
#import "BackView.h"
#import "../AppDelegate.h"

@class AppDelegate;

@interface LockWindow : NSWindow 


- (instancetype)init;
// - (instancetype)initWithParent: (AppDelegate*) parent;
- (BOOL)windowShouldClose:(id)sender;
- (void)onTimerTick:(NSTimer*)timer;
- (void)onTimerQuit:(NSTimer*)timer;
- (void)updateTime;
- (void)setAppearance:(BOOL) locked;

@end

