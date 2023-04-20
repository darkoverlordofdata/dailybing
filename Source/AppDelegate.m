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


- (instancetype)initWithFlags:(BOOL)help version:(BOOL)version schedule:(BOOL)schedule lockscreen:(BOOL)lockscreen pin:(NSString*)pin at:(NSString*)at
{
    _help = help;
    _version = version;
    _schedule = schedule;
    _lockscreen = lockscreen;
    _pin = [[NSString alloc]initWithString:pin? pin:@""];
    _at = [[NSString alloc]initWithString:at? at:@""];

    return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
{
    /**
     * Display help message
     */
    if (_help) {
        NSLog(@"Usage: openapp DailyBing [OPTION ...]");
        NSLog(@"-h, --help          display this help message");
        NSLog(@"-v, --version       display version");
        NSLog(@"-s, --schedule      schedule download");
        NSLog(@"-a, --at            schedule time if not 1:00 am");
        NSLog(@"-l, --lockscreen    run the lock screen module");
        NSLog(@"-p, --pin           set custom pin for lock screen");
        [NSApp terminate:nil];

    /**
     * Display version
     */
    } else if (_version) {
        NSLog(@"DailyBing Version 1.01");
        [NSApp terminate:nil];

    /**
     * Run LockScreen
     */
    } else if (_lockscreen) {

        _window = [[LockWindow alloc] init];
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

        _window = [[ImageWindow alloc] init];
        [_window setDelegate:self];
    }
    
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end


