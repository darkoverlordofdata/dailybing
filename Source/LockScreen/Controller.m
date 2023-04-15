#import "Controller.h"

@implementation Controller

- (void) applicationWillFinishLaunching: (NSNotification *)aNotification;
{

}

- (void) applicationDidFinishLaunching: (NSNotification *) not
{
    _window = [LockWindow new];
    [_window setDelegate:self];

}

@end