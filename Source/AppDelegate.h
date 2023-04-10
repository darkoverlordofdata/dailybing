/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Interactive/DBWindow.h"
#import "LockScreen/LockWindow.h"

@interface AppDelegate : NSObject {
    BOOL _help;
    BOOL _version;
    BOOL _schedule;
    BOOL _lockscreen;
    NSString *_pin;
    NSString *_at;

}

@property (strong, nonatomic) NSWindow *window;
// @property (strong, nonatomic) DBWindow *window;

- (instancetype)initWithFlags:(BOOL)help version:(BOOL)version schedule:(BOOL)schedule lockscreen:(BOOL)lockscreen pin:(NSString*)pin at:(NSString*)at;

// - (void)applicationWillFinishLaunching:(NSNotification *) not;
- (void)applicationDidFinishLaunching:(NSNotification *) not;


@end

