#import "LockWindow.h"
#import <GNUstepGUI/GSDisplayServer.h>
// #import <X11/Xlib.h>


@implementation LockWindow

/**
 *  Type Constructor
 */
- (instancetype)init {
  counter = 0;
  input = [NSString new];
  NSSize resolution = [[NSScreen mainScreen] frame].size;
  [super
      initWithContentRect:NSMakeRect(0, 0, resolution.width, resolution.height)
                styleMask:NSBorderlessWindowMask 
                  backing:NSBackingStoreBuffered 
                    defer:NO];
  

  /**
   * Load the bundle data
   */
  NSString *root =
      @"/usr/GNUstep/Local/Applications/DailyBing.app/Resources/themes";
  NSString *_locked =
      [NSString stringWithFormat:@"%@/%@", root, @"wallpaper.locked.jpg"];
  NSString *_authorize =
      [[NSString stringWithFormat:@"%@/%@", root, @"wallpaper.authorize.jpg"] retain];
  NSString *_textFile =
      [NSString stringWithFormat:@"%@/%@", root, @"wallpaper.description"];

  /**
   * Parse the bundle data
   */
  NSString *content = [NSString stringWithContentsOfFile:_textFile
                                                encoding:NSUTF8StringEncoding
                                                   error:NULL];

  NSArray *content0 = [content componentsSeparatedByString:@"\n"];

  NSString *_titleString = content0[0];
  NSArray *content1 = [content0[1] componentsSeparatedByString:@"("];
  NSString *_descriptionString = content1[0];
  // NSString *_copyrightString = content1[1];
  NSString *_copyrightString = [content1[1] substringToIndex:[content1[1] length]-1];

  /**
   *  Setup the wallpaper.locked.jpg image
   */
  wallpaperLocked = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(0, 0, resolution.width, resolution.height)]
      autorelease];
  [wallpaperLocked setImage:[[NSImage alloc] initWithContentsOfFile:_locked]];

  /**
   *  Setup the wallpaper.authorize.jpg image
   */
  wallpaperAuthorize = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(0, 0, resolution.width, resolution.height)]
      autorelease];
  [wallpaperAuthorize setImage:[[NSImage alloc] initWithContentsOfFile:_authorize]];
  [wallpaperAuthorize setHidden:YES];

  // [super
  //     initWithContentRect:NSMakeRect(0, 0, resolution.width, resolution.height)
  //               styleMask:NSBorderlessWindowMask
  //                 backing:NSBackingStoreBuffered
  //                   defer:NO];
  [[self contentView] addSubview:wallpaperLocked];
  [[self contentView] addSubview:wallpaperAuthorize];

  [self orderFrontRegardless];
  [self setLevel:NSScreenSaverWindowLevel - 1];
  [self setAutodisplay:YES];
  [self makeFirstResponder:self];
  [self setExcludedFromWindowsMenu:YES];
  [self setHasShadow:NO];
  [self setOpaque:NO];
  [self setBackgroundColor:[NSColor clearColor]];



  NSString* fullName = @"bruce davidson";

  userName = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - ([fullName length] / 2) - [fullName length] * 5,
                               resolution.height*.5 - 80, 400, 24)]
      autorelease];
  [userName setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                         size:24]];
  [userName setStringValue:fullName];
  [userName setBezeled:NO];
  [userName setBezelStyle:NSTextFieldRoundedBezel];
  [userName setDrawsBackground:NO];
  [userName setEditable:NO];
  [userName setSelectable:NO];
  [userName setHidden:YES];
  [userName setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:userName];


  avatar = [[[NSImageView alloc]
      initWithFrame:NSMakeRect(resolution.width * .5 - 64, 
                                resolution.height * .5, 128, 128)]
      autorelease];
  [avatar setImage:[[NSImage imageNamed:@"avatar.png"]imageByScalingProportionallyToSize:NSMakeSize(256,256)]];
  [avatar setHidden:YES];
  [[self contentView] addSubview:avatar];

  /*
   * background for PIN input
   */
  backView = [[BackView alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - 225,
                               resolution.height / 3, 450, 55)];
  [backView setHidden:YES];
  [[self contentView] addSubview:backView];

  /*
   * Enter PIN
   */
  passcode = [[[NSSecureTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - 200,
                               resolution.height / 3 - 24, 400, 96)]
      autorelease];

//  [[NSColor colorWithDeviceRed:rr green:gg blue:bb alpha:1.0f] set];

  [passcode setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                    size:96]];
  [passcode setStringValue:input];

  //  https://www.colorhexa.com/36454f
  NSColor *charcoalColor = [NSColor colorWithDeviceRed:(float)0x36 / (float)255
                                     green:(float)0x45 / (float)255 
                                     blue:(float)0x4f / (float)255 
                                     alpha:1.0f]; 

  // [passcode setTextColor:[NSColor darkGrayColor]];
  [passcode setTextColor:charcoalColor];
  [passcode setBezeled:NO];
  [passcode setBezelStyle:NSTextFieldRoundedBezel];
  [passcode setDrawsBackground:NO];
  [passcode setEditable:NO];
  [passcode setSelectable:NO];
  [passcode setHidden:YES];
  [[self contentView] addSubview:passcode];

  /*
   * Display instructions:
   *  Enter PIN
   */
  NSFont *inFont = [NSFont fontWithName:@"SanFranciscoDisplay-Medium" size:24];
  CGFloat inSize = [inFont widthOfString:@"Enter PIN"];
  instructions = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(resolution.width / 2 - (inSize / 2),
                               resolution.height / 3 - 80, 400, 24)]
      autorelease];

  [instructions setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                         size:24]];
  [instructions setStringValue:@"Enter PIN"];
  [instructions setBezeled:NO];
  [instructions setBezelStyle:NSTextFieldRoundedBezel];
  [instructions setDrawsBackground:NO];
  [instructions setEditable:NO];
  [instructions setSelectable:NO];
  [instructions setHidden:YES];
  [instructions setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:instructions];

  /*
   * Display date:
   *  Monday, January 31
   */
  currentDate = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, 80, 800, 64)] autorelease];

  [currentDate setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                        size:64]];
  [currentDate setBezeled:NO];
  [currentDate setBezelStyle:NSTextFieldRoundedBezel];
  [currentDate setDrawsBackground:NO];
  [currentDate setEditable:NO];
  [currentDate setSelectable:NO];
  [currentDate setHidden:NO];
  [currentDate setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:currentDate];
  [self updateTime];

  /*
   * Display time:
   *  1:01 am
   */
  currentTime = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, 200, 800, 128)] autorelease];

  [currentTime setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                        size:128]];
  [currentTime setBezeled:NO];
  [currentTime setBezelStyle:NSTextFieldRoundedBezel];
  [currentTime setDrawsBackground:NO];
  [currentTime setEditable:NO];
  [currentTime setSelectable:NO];
  [currentTime setHidden:NO];
  [currentTime setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:currentTime];
  [self updateTime];

  /*
   * Display title:
   */
  title = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 80, 800, 32)]
      autorelease];

  [title setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium" size:32]];
  [title setBezeled:NO];
  [title setBezelStyle:NSTextFieldRoundedBezel];
  [title setDrawsBackground:NO];
  [title setEditable:NO];
  [title setSelectable:NO];
  [title setHidden:NO];
  [title setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:title];
  [title setStringValue:_titleString];

  /*
   * Display description:
   */
  description = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 110, 800, 24)]
      autorelease];

  [description setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                        size:24]];
  [description setBezeled:NO];
  [description setBezelStyle:NSTextFieldRoundedBezel];
  [description setDrawsBackground:NO];
  [description setEditable:NO];
  [description setSelectable:NO];
  [description setHidden:NO];
  [description setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:description];
  [description setStringValue:_descriptionString];

  /*
   * Display copyright:
   */
  copyright = [[[NSTextField alloc]
      initWithFrame:NSMakeRect(60, resolution.height - 140, 800, 18)]
      autorelease];

  [copyright setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                      size:18]];
  [copyright setBezeled:NO];
  [copyright setBezelStyle:NSTextFieldRoundedBezel];
  [copyright setDrawsBackground:NO];
  [copyright setEditable:NO];
  [copyright setSelectable:NO];
  [copyright setHidden:NO];
  [copyright setTextColor:[NSColor whiteColor]];
  [[self contentView] addSubview:copyright];
  [copyright setStringValue:_copyrightString];

  timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
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
        [wallpaperLocked setHidden:NO];
        [wallpaperAuthorize setHidden:YES];
        [avatar setHidden:YES];
        [userName setHidden:YES];
        [backView setHidden:YES];
        [passcode setHidden:YES];
        [instructions setHidden:YES];
        [title setHidden:NO];
        [description setHidden:NO];
        [copyright setHidden:NO];
        [currentTime setHidden:NO];
        [currentDate setHidden:NO];

    } else {
        [wallpaperLocked setHidden:YES];
        [wallpaperAuthorize setHidden:NO];
        [avatar setHidden:NO];
        [userName setHidden:NO];
        [backView setHidden:NO];
        [passcode setHidden:NO];
        [instructions setHidden:NO];
        [title setHidden:YES];
        [description setHidden:YES];
        [copyright setHidden:YES];
        [currentTime setHidden:YES];
        [currentDate setHidden:YES];

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
  [currentDate setStringValue:dateString];
  [currentTime setStringValue:timeString];
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

  counter++;
  if (counter > 15) {
      input = [NSString new];
      [passcode setStringValue:input];
      [self setAppearance:YES];
      counter = 0;
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

    counter = 0;

    int keyCode = [theEvent keyCode];
    NSString *str = [theEvent characters];
    int ch = [str characterAtIndex:0];

    if (ch == 27) {
      NSLog(@"<esc> %i", ch);
      input = [NSString new];
      [passcode setStringValue:input];
      [self setAppearance:YES];
      return;
    }

    switch (keyCode) {
    case 22: //  backspace
      NSLog(@"<backspace> %i", ch);
      if ([input length] <= 0)
        break;
      input = [input substringToIndex:[input length] - 1];
      [passcode setStringValue:input];
      break;

    case 36: //  return
      NSLog(@"<return> %i", ch);
      input = [NSString new];
      [passcode setStringValue:input];
      break;

    default:
      NSLog(@"key code %@ | %i", str, ch);
      if (ch > 255) break;

      input = [input stringByAppendingString:str];
      [passcode setStringValue:input];
      if ([input isEqualToString:@"420420"]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.25f
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
