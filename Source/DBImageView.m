/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"

@implementation DBImageView;

- (instancetype)initWithIndex:(int)index 
{
    [[self initWithFrame:NSMakeRect(index*240, 0, 240, 135)] autorelease];
    return self;

}


- (void)mouseDown:(NSEvent *)theEvent
{
    NSInteger clickCount = [theEvent clickCount];

    [(DBWindow *)_window onSelect: self];

    if (clickCount > 1) {
        // User at least double clicked in image view
    }
}
@end