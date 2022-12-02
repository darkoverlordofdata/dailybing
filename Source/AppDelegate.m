/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
{
    _window = [[Window alloc] init];
    [_window setDelegate:self];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end


