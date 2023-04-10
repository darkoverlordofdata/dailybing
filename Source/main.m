/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
#import "Interactive/DBWindow.h"

#include <getopt.h>


/**
 * Decode process arguments
 */
static const struct option longopts[] = {
    {"help", no_argument, NULL, 'h'},
    {"lockscreen", no_argument, NULL, 'l'},
    {"schedule", no_argument, NULL, 's'},
    {"version", no_argument, NULL, 'v'},
    {"at", required_argument, NULL, 'a'},
    {"pin", required_argument, NULL, 'p'}
};


int main(int argc, char *argv[]) 
{

  @autoreleasepool {
    [NSApplication sharedApplication];
    NSLog(@"%s", argv[0]);

    int longindex = -1, opt;
    BOOL help = NO;
    BOOL version = NO;
    BOOL schedule = NO;
    BOOL lockscreen = NO;
    NSString *pin;
    NSString *at;

    while ((opt = getopt_long(argc, argv, "hlsva:p:", longopts, &longindex))
          != -1) {
        switch (opt) {
        case 'h':
            help = YES;
            break;
        case 'l':
            lockscreen = YES;
            break;
        case 's':
            schedule = YES;
            break;
        case 'v':
            version = YES;
            break;


        case 'a':
            at = [NSString stringWithCString:optarg];
            // at = strdup(optarg);
            break;
        case 'p':
            pin = [NSString stringWithCString:optarg];
            // pin = strdup(optarg);
            break;

        }
   }


    AppDelegate *controller = [[AppDelegate alloc]initWithFlags:help version:version schedule:schedule lockscreen:lockscreen pin:pin at:at];
    [[NSApplication sharedApplication] setDelegate: controller];

    NSApplicationMain(argc, (const char **)argv);

  }
  return 0;
}

