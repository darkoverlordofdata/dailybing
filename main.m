#import <Cocoa/Cocoa.h>
#import "Controller.h"
#import "Window.h"


int main(int argc, const char *argv[]) 
{

  @autoreleasepool {
    [NSApplication sharedApplication];
    Controller *controller = [Controller new];
    [[NSApplication sharedApplication] setDelegate: controller];

    NSApplicationMain(argc, argv);

  }
}

