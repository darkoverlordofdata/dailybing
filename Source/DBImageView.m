/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"

@implementation DBImageView;

@synthesize url = _url;
@synthesize desc = _desc;
@synthesize title = _title;
@synthesize urlBase = _urlBase;

//   NSString *imageUrl1 = [image1 valueForKey:@"url"];

- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data
{
    [[self initWithFrame:NSMakeRect(index*240, 0, 240, 135)] autorelease];

    _url = [[NSString alloc]initWithString:[data valueForKey:@"url"]];
    _desc = [[NSString alloc] initWithString:[data valueForKey:@"copyright"]];
    _title = [[NSString alloc] initWithString:[data valueForKey:@"title"]];
    _urlBase = [[NSString alloc] initWithString:[data valueForKey:@"urlbase"]];
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