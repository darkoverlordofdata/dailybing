/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Interactive/ImageWindow.h"
#import "LockScreen/LockWindow.h"



@interface AppDelegate : NSObject 

@property (assign, nonatomic) BOOL help;
@property (assign, nonatomic) BOOL version;
@property (assign, nonatomic) BOOL schedule;
@property (assign, nonatomic) BOOL lockscreen;
@property (strong, nonatomic) NSString *pin;
@property (strong, nonatomic) NSString *at;
@property (strong, nonatomic) NSString *font;
@property (strong, nonatomic) NSString *defaultPin;
@property (strong, nonatomic) NSString *defaultAt;
@property (strong, nonatomic) NSString *defaultFont;
@property (strong, nonatomic) NSWindow *window;
@property (assign, nonatomic) BOOL plank;
@property (assign, nonatomic) BOOL menu;
@property (assign, nonatomic) BOOL dde_dock;
@property (assign, nonatomic) BOOL dde_top_panel;


// - (instancetype)initWithPin:(NSString*)pin at:(NSString*)at font:(NSString*)font;
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

- (void)applicationDidFinishLaunching:(NSNotification *) not;
- (void)applicationWillTerminate:(NSNotification *) not;

@end

