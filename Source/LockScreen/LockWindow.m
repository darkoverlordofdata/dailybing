#include "AppKit/NSCell.h"
#include "AppKit/NSText.h"
#import <pwd.h>
#import "LockWindow.h"


@implementation LockWindow {
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

  AppDelegate* _app;
  NSString *_font;
  NSString *_pin;

}


/**
 *  Type Constructor
 */
// - (instancetype)init
- (instancetype)initWithParent: (AppDelegate*) app
{

  _app = app;
  _font = [app font];
  _pin = [app pin];

  NSLog(@"Using font: %@", _font);
  NSLog(@"Using pin: %@", _pin);
  _counter = 0;
  _input = [NSString new];
  NSSize resolution = [[NSScreen mainScreen] frame].size;
  self = [super
      initWithContentRect:NSMakeRect(0, 0, resolution.width, resolution.height)
                styleMask:NSBorderlessWindowMask 
                  backing:NSBackingStoreBuffered 
                    defer:NO];
  

  /**
   * Load the bundle data
   */
  NSString *bundlePath = [[NSBundle mainBundle] bundlePath]; 

  NSLog(@"bundlePath: %@", bundlePath);

  NSString *locked = 
      [NSString stringWithFormat:@"%@/%@", bundlePath, @"Resources/themes/wallpaper.locked.jpg"];
  NSString *authorize = 
      [NSString stringWithFormat:@"%@/%@", bundlePath, @"Resources/themes/wallpaper.authorize.jpg"];
  NSString *textFile = 
      [NSString stringWithFormat:@"%@/%@", bundlePath, @"Resources/themes/wallpaper.description"];


  /**
   * Parse the bundle data
   */
  NSString *content = [NSString stringWithContentsOfFile:textFile
                                                encoding:NSUTF8StringEncoding
                                                   error:NULL];

  NSArray<NSString *> *content0 = [content componentsSeparatedByString:@"\n"];

  NSString *titleString = content0[0];
  NSArray<NSString *> *content1 = [content0[1] componentsSeparatedByString:@"("];
  NSString *descriptionString = content1[0];
  NSString *copyrightString = [content1[1] substringToIndex:[content1[1] length]-1];

  /**
   *  Setup the wallpaper.locked.jpg image
   */
  _wallpaperLocked = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(0, 0, resolution.width, resolution.height)]
      autorelease];
  [_wallpaperAuthorize setImageScaling: NSScaleNone];
  [_wallpaperLocked setImage:[[NSImage alloc] initWithContentsOfFile:locked]];

  /**
   *  Setup the wallpaper.authorize.jpg image
   */
  _wallpaperAuthorize = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(0, 0, resolution.width, resolution.height)]
      autorelease];
  [_wallpaperAuthorize setImageScaling: NSScaleNone];
  [_wallpaperAuthorize setImage:[[NSImage alloc] initWithContentsOfFile:authorize]];
  [_wallpaperAuthorize setHidden:YES];

  [[self contentView] addSubview:_wallpaperLocked];
  [[self contentView] addSubview:_wallpaperAuthorize];

  [self becomeMainWindow];
  [self becomeKeyWindow];
  [self orderFrontRegardless];
  [self setLevel:NSScreenSaverWindowLevel - 1];
  [self setAutodisplay:YES];
  [self makeFirstResponder:self];
  [self setExcludedFromWindowsMenu:YES];
  [self setHasShadow:NO];
  [self setOpaque:NO];
  [self setBackgroundColor:[NSColor clearColor]];



  struct passwd *pw = getpwuid(getuid());
  NSString *fullName = [NSString stringWithCString:strdup(pw->pw_gecos)];

  _userName = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - ([fullName length] / 2) - [fullName length] * 5,
                               resolution.height*.5 - 80, 400, 24)]
      autorelease];
  [_userName setFont:[NSFont fontWithName:_font
                                         size:24]];
  [_userName setStringValue:fullName];
  [_userName setBezeled:NO];
  [_userName setBezelStyle:NSTextFieldRoundedBezel];
  [_userName setDrawsBackground:NO];
  [_userName setEditable:NO];
  [_userName setSelectable:NO];
  [_userName setHidden:YES];
  [_userName setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_userName];


  _avatar = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(resolution.width * .5 - 64, 
                                resolution.height * .5, 128, 128)]
      autorelease];
  [_avatar setImage:[[NSImage imageNamed:@"avatar.png"]imageByScalingProportionallyToSize:NSMakeSize(256,256)]];
  [_avatar setHidden:YES];
  [[self contentView] addSubview:_avatar];

  /*
   * background for PIN input
   */
  _backView = [[BackView alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - 225,
                               resolution.height / 3, 450, 55)];
  [_backView setHidden:YES];
  [[self contentView] addSubview:_backView];

  /*
   * Enter PIN
   */
  _passcode = [[[NSSecureTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - 200,
                               resolution.height / 3 - 24, 400, 96)]
      autorelease];

  [_passcode setFont:[NSFont fontWithName:_font size:96]];

  //  Charcoal #36454f
  NSColor *charcoalColor = [NSColor colorWithDeviceRed:(float)0x36 / (float)255
                                     green:(float)0x45 / (float)255 
                                     blue:(float)0x4f / (float)255 
                                     alpha:1.0f]; 

  [_passcode setTextColor:charcoalColor];
  [_passcode setStringValue:_input];
  [_passcode setBezeled:NO];
  [_passcode setBezelStyle:NSTextFieldRoundedBezel];
  [_passcode setDrawsBackground:NO];
  [_passcode setEditable:NO];
  [_passcode setSelectable:NO];
  [_passcode setHidden:YES];
  [_passcode setAlignment:NSTextAlignmentCenter];
  [[self contentView] addSubview:_passcode];

  /*
   * Display instructions:
   *  Enter PIN
   */
  NSFont *inFont = [NSFont fontWithName:_font size:24];
  CGFloat inSize = [inFont widthOfString:@"Enter PIN"];
  _instructions = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - (inSize / 2),
                               resolution.height / 3 - 80, 400, 24)]
      autorelease];

  [_instructions setFont:[NSFont fontWithName:_font
                                         size:24]];
  [_instructions setStringValue:@"Enter PIN"];
  [_instructions setBezeled:NO];
  [_instructions setBezelStyle:NSTextFieldRoundedBezel];
  [_instructions setDrawsBackground:NO];
  [_instructions setEditable:NO];
  [_instructions setSelectable:NO];
  [_instructions setHidden:YES];
  [_instructions setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_instructions];

  /*
   * Display date:
   *  Monday, January 31
   */
  _currentDate = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, 80, 800, 64)] autorelease];

  [_currentDate setFont:[NSFont fontWithName:_font
                                        size:64]];
  [_currentDate setBezeled:NO];
  [_currentDate setBezelStyle:NSTextFieldRoundedBezel];
  [_currentDate setDrawsBackground:NO];
  [_currentDate setEditable:NO];
  [_currentDate setSelectable:NO];
  [_currentDate setHidden:NO];
  [_currentDate setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_currentDate];
  [self updateTime];

  /*
   * Display time:
   *  1:01 am
   */
  _currentTime = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, 200, 800, 128)] autorelease];

  [_currentTime setFont:[NSFont fontWithName:_font
                                        size:128]];
  [_currentTime setBezeled:NO];
  [_currentTime setBezelStyle:NSTextFieldRoundedBezel];
  [_currentTime setDrawsBackground:NO];
  [_currentTime setEditable:NO];
  [_currentTime setSelectable:NO];
  [_currentTime setHidden:NO];
  [_currentTime setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_currentTime];
  [self updateTime];

  /*
   * Display title:
   */
  _title = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 80, 800, 32)]
      autorelease];

  [_title setFont:[NSFont fontWithName:_font size:32]];
  [_title setBezeled:NO];
  [_title setBezelStyle:NSTextFieldRoundedBezel];
  [_title setDrawsBackground:NO];
  [_title setEditable:NO];
  [_title setSelectable:NO];
  [_title setHidden:NO];
  [_title setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_title];
  [_title setStringValue:titleString];

  /*
   * Display description:
   */
  _description = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 110, 800, 24)]
      autorelease];

  [_description setFont:[NSFont fontWithName:_font
                                        size:24]];
  [_description setBezeled:NO];
  [_description setBezelStyle:NSTextFieldRoundedBezel];
  [_description setDrawsBackground:NO];
  [_description setEditable:NO];
  [_description setSelectable:NO];
  [_description setHidden:NO];
  [_description setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_description];
  [_description setStringValue:descriptionString];

  /*
   * Display copyright:
   */
  _copyright = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 140, 800, 18)]
      autorelease];

  [_copyright setFont:[NSFont fontWithName:_font
                                      size:18]];
  [_copyright setBezeled:NO];
  [_copyright setBezelStyle:NSTextFieldRoundedBezel];
  [_copyright setDrawsBackground:NO];
  [_copyright setEditable:NO];
  [_copyright setSelectable:NO];
  [_copyright setHidden:NO];
  [_copyright setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:_copyright];
  [_copyright setStringValue:copyrightString];

  _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                           target:self
                                         selector:@selector(onTimerTick:)
                                         userInfo:nil
                                          repeats:YES];
  return self;
}

/**
 * setAppearance:locked
 */
- (void)setAppearance:(BOOL) locked
{
    if (locked) {
        [_wallpaperLocked setHidden:NO];
        [_wallpaperAuthorize setHidden:YES];
        [_avatar setHidden:YES];
        [_userName setHidden:YES];
        [_backView setHidden:YES];
        [_passcode setHidden:YES];
        [_instructions setHidden:YES];
        [_title setHidden:NO];
        [_description setHidden:NO];
        [_copyright setHidden:NO];
        [_currentTime setHidden:NO];
        [_currentDate setHidden:NO];

    } else {
        [_wallpaperLocked setHidden:YES];
        [_wallpaperAuthorize setHidden:NO];
        [_avatar setHidden:NO];
        [_userName setHidden:NO];
        [_backView setHidden:NO];
        [_passcode setHidden:NO];
        [_instructions setHidden:NO];
        [_title setHidden:YES];
        [_description setHidden:YES];
        [_copyright setHidden:YES];
        [_currentTime setHidden:YES];
        [_currentDate setHidden:YES];

    }
}


/**
 * updateTime
 */
- (void)updateTime 
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"EEEE,  MMMM d"];

  NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
  [timeFormat setDateFormat:@"h:mm a"];

  NSDate *theDate = [NSDate date];
  NSString *dateString = [dateFormat stringFromDate:theDate];
  NSString *timeString = [timeFormat stringFromDate:theDate];
  [_currentDate setStringValue:dateString];
  [_currentTime setStringValue:timeString];
}

/**
 * onTimerQuit:timer
 */
- (void)onTimerQuit:(NSTimer *)timer 
{
  [[NSApplication sharedApplication] terminate:nil];
}

/**
 * onTimerTick:timer
 */
- (void)onTimerTick:(NSTimer *)timer 
{
  [self updateTime];

  _counter++;
  if (_counter > 15) {
      _input = [NSString new];
      [_passcode setStringValue:_input];
      [self setAppearance:YES];
      _counter = 0;
      // [NSApp terminate:nil];
      return;

  }
}

/**
 * windowShouldClose:sender
 */
- (BOOL)windowShouldClose:(id)sender 
{
  [NSApp terminate:sender];
  return YES;
}

/**
 * On KeyDown, display text input (NSTextField)
 *
 */
- (void)keyDown:(NSEvent *)theEvent 
{
  if ([self level] != NSDesktopWindowLevel) {
    [self setAppearance:NO];

    _counter = 0;

    int keyCode = [theEvent keyCode];
    NSString *str = [theEvent characters];
    int ch = [str characterAtIndex:0];

    if (ch == 27) {
      NSLog(@"<esc> %i", ch);
      _input = [NSString new];
      [_passcode setStringValue:_input];
      [self setAppearance:YES];
      return;
    }

    switch (keyCode) {
    case 22: //  backspace
      NSLog(@"<backspace> %i", ch);
      if ([_input length] <= 0)
        break;
      _input = [_input substringToIndex:[_input length] - 1];
      [_passcode setStringValue:_input];
      break;

    case 36: //  return
      NSLog(@"<return> %i", ch);
      _input = [NSString new];
      [_passcode setStringValue:_input];
      break;

    default:
      NSLog(@"key code %@ | %i", str, ch);
      if (ch > 255) break;

      _input = [_input stringByAppendingString:str];
      [_passcode setStringValue:_input];
      if ([_input isEqualToString:_pin]) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.25f
                                                 target:self
                                               selector:@selector(onTimerQuit:)
                                               userInfo:nil
                                                repeats:NO];
      }

    }
  }
}

/**
 * canBecomeKeyWindow
 */
- (BOOL)canBecomeKeyWindow 
{
  return YES;
}

/**
 * canBecomeMainWindow
 */
- (BOOL)canBecomeMainWindow 
{
  return YES;
}

/**
 * hide:sender
 */
- (void)hide:(id)sender 
{
}
@end
