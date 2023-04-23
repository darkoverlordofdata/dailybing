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

// - (instancetype)initWithPin:(NSString*)pin at:(NSString*)at font:(NSString*)font;
- (instancetype)initWithFlags:(BOOL)help version:(BOOL)version schedule:(BOOL)schedule lockscreen:(BOOL)lockscreen pin:(NSString*)pin at:(NSString*)at font:(NSString*)font ;

- (void)applicationDidFinishLaunching:(NSNotification *) not;


@end

