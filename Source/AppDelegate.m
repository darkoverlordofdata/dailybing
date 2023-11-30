/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize help = _help;
@synthesize version = _version;
@synthesize schedule = _schedule;
@synthesize lockscreen = _lockscreen;
@synthesize pin = _pin;
@synthesize at = _at;
@synthesize font = _font;
@synthesize defaultPin = _defaultPin;
@synthesize defaultAt = _defaultAt;
@synthesize defaultFont = _defaultFont;
@synthesize plank = _plank;
@synthesize menu = _menu;
@synthesize dde_dock = _dde_dock;
@synthesize dde_top_panel = _dde_top_panel;


- (instancetype) init
{
    _defaultPin = @"420420";
    _defaultAt = @"01:01";
    _defaultFont = @"SanFranciscoDisplay-Medium";
    // _defaultFont = @"NimbusSans-Regular";
    return self;

}


- (instancetype)initWithFlags:(BOOL)help 
                      version:(BOOL)version 
                     schedule:(BOOL)schedule 
                   lockscreen:(BOOL)lockscreen 
                          pin:(NSString*)pin 
                           at:(NSString*)at 
                         font:(NSString*)font
                        plank:(BOOL)plank
                         menu:(BOOL)menu
                     dde_dock:(BOOL)dde_dock
                dde_top_panel:(BOOL)dde_top_panel;
{
    self = [self init];
    
    _help = help;
    _version = version;
    _schedule = schedule;
    _lockscreen = lockscreen;

    _pin = [pin isEqualToString:@""]? _defaultPin : pin;
    _at = [at isEqualToString:@""]? _defaultAt : at;
    _font = [font isEqualToString:@""]? _defaultFont : font;

    _plank = plank;
    _menu = menu;
    _dde_dock = dde_dock;
    _dde_top_panel = dde_top_panel;

    return self;
}

- (void)applicationWillTerminate:(NSNotification *) not
{
    if (_lockscreen) {      
        // [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dde-top-panel" arguments:@[]];        
        // [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dde-dock" arguments:@[]];        
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /**
     * Display help message
     */
    if (_help) {
        printf("Usage: openapp DailyBing [OPTION ...]\n");
        printf("-1, --plank\n");
        printf("-2, --Menu\n");
        printf("-3, --dde-dock\n");
        printf("-4, --dde-top-panel\n");
        printf("-h, --help          display this help message\n");
        printf("-v, --version       display version\n");
        printf("-s, --schedule      schedule download\n");
        printf("-a, --at            schedule time if not 1:00 am\n");
        printf("-l, --lockscreen    run the lock screen module\n");
        printf("-p, --pin           set custom pin for lock screen\n");
        printf("-f, --font          set font for lock screen\n");
        [NSApp terminate:nil];

    /**
     * Display version
     */
    } else if (_version) {
        printf("DailyBing Version 1.01\n");
        [NSApp terminate:nil];

    /**
     * Run LockScreen
     */
    } else if (_lockscreen) {

        // if ([[[[NSProcessInfo processInfo] environment] objectForKey:@"DESKTOP_SESSION"] isEqualToString:@"dde-x11"])
        // {
            if (_plank)
                [NSTask launchedTaskWithLaunchPath:@"/usr/bin/pkill" arguments:[NSArray arrayWithObjects:@"plank", nil]];        

            if (_menu)
                [NSTask launchedTaskWithLaunchPath:@"/usr/bin/pkill" arguments:[NSArray arrayWithObjects:@"Menu", nil]];        

            if (_dde_dock)
                [NSTask launchedTaskWithLaunchPath:@"/usr/bin/pkill" arguments:[NSArray arrayWithObjects:@"dde-dock", nil]];        

            if (_dde_top_panel)
                [NSTask launchedTaskWithLaunchPath:@"/usr/bin/pkill" arguments:[NSArray arrayWithObjects:@"dde-top-panel", nil]];        
            
        // }        

        _window = [[LockWindow alloc] initWithParent:self];
        [_window setDelegate:self];

    /**
     *  Run Scheduler
     */
    } else if (_schedule) {

        [NSApp terminate:nil];

    /**
     *  Run Interactive
     */
    } else {

        _window = [[ImageWindow alloc] initWithParent:self];
        [_window setDelegate:self];
    }
    
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end


