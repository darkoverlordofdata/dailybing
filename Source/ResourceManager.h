/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>

@interface ResourceManager : NSObject 
@property (strong, nonatomic) NSString *resourcePath;
+ (id)sharedManager;

@end