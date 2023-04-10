/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"
#import "DBDataIndex.h"

@class DBImageView;
@class DBDataIndex;

@interface DBWindow : NSWindow;

- (instancetype) init;
- (BOOL) windowShouldClose:(id)sender;



@end
