/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>
#import "AppDelegate.h"
// #import "Interactive/ImageWindow.h"

#include <getopt.h>


/**
 * Decode process arguments
 */
static const struct option longopts[] = {
    {"plank", no_argument, NULL, '1'},
    {"Menu", no_argument, NULL, '2'},
    {"dde-dock", no_argument, NULL, '3'},
    {"dde-top-panel", no_argument, NULL, '4'},
    {"xfce4-panel", no_argument, NULL, '5'},
    {"help", no_argument, NULL, 'h'},
    {"lockscreen", no_argument, NULL, 'l'},
    {"schedule", no_argument, NULL, 's'},
    {"version", no_argument, NULL, 'v'},
    {"at", required_argument, NULL, 'a'},
    {"pin", required_argument, NULL, 'p'},
    {"font", required_argument, NULL, 'f'},
    {0,0,0,0}
};


int main(int argc, char *argv[]) 
{

  @autoreleasepool {
    [NSApplication sharedApplication];

    int longindex = -1, opt;
    BOOL task_plank = NO;
    BOOL task_Menu = NO;
    BOOL task_dde_dock = NO;
    BOOL task_dde_top_panel = NO;
    BOOL task_xfce4_panel = NO;
    BOOL help = NO;
    BOOL version = NO;
    BOOL schedule = NO;
    BOOL lockscreen = NO;
    NSString *pin = @"";
    NSString *at = @"";
    NSString *font = @"";

    // NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];

    // NSString *aString = [standardDefaults stringForKey:@"aString"];
    // NSInteger anInteger = [standardDefaults integerForKey:@"anInteger"];

    // NSLog (@"aString argument: %@\nanInteger argument: %ld", aString, anInteger);
    

    while ((opt = getopt_long(argc, argv, "12345hlsva:p:f:", longopts, &longindex))
          != -1) {
        switch (opt) {

        case '1':       // plank
            task_plank = YES;
            break;      
        case '2':       // Menu
            task_Menu = YES;
            break;      
        case '3':       // dde-dock
            task_dde_dock = YES;
            break;      
        case '4':       // dde-top-panel
            task_dde_top_panel = YES;
            break;      
        case '5':       // xfce4-panel
            task_xfce4_panel = YES;
            break;      

        case 'h':       //  --help
            help = YES;
            break;      
        case 'l':       //  --lockscreen
            lockscreen = YES;
            break;
        case 's':       //  --schedule
            schedule = YES;
            break;
        case 'v':       //  --version
            version = YES;  
            break;

        case 'a':       //  --at
            at = [NSString stringWithCString:optarg];
            break;
        case 'p':       //  --pin
            pin = [NSString stringWithCString:optarg];
            break;
        case 'f':       //  --font
            font = [NSString stringWithCString:optarg];
            break;

        case 't':       //  --task
            break;

        }
   }


    AppDelegate *controller = [[AppDelegate alloc]initWithFlags:help 
                                                        version:version 
                                                       schedule:schedule 
                                                     lockscreen:lockscreen 
                                                            pin:pin 
                                                             at:at 
                                                           font:font
                                                          plank:task_plank
                                                           menu:task_Menu
                                                       dde_dock:task_dde_dock
                                                  dde_top_panel:task_dde_top_panel
                                                    xfce4_panel:task_xfce4_panel];
    [[NSApplication sharedApplication] setDelegate: controller];

    NSApplicationMain(argc, (const char **)argv);

  }
  return 0;
}

