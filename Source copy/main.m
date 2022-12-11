/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "DBWindow.h"


int main(int argc, const char *argv[]) 
{

  @autoreleasepool {
    [NSApplication sharedApplication];
    NSLog(@"%s", argv[0]);
    AppDelegate *controller = [AppDelegate new];
    [[NSApplication sharedApplication] setDelegate: controller];

    NSApplicationMain(argc, argv);

  }
  return 0;
}

