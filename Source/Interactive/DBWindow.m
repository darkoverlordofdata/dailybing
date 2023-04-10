/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"

@implementation DBWindow
- (instancetype)init {
        
	[[DBDataIndex alloc] initWithParent:self];

	[super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
	[self setTitle:@"Bing Picture Of the Day"];

	if ([NSWindow instancesRespondToSelector:@selector(setIsVisible:)]) {
		// Latest version on Linux has fixed this
		NSLog(@"use setIsVisible");
		[self setIsVisible:YES];
	} else {
		// Latest version on FreeBSD doesn't have the fix yet...
		NSLog(@"use orderFrontRegardless");
  		[self orderFrontRegardless];
	}


	NSSize resolution =  [[NSScreen mainScreen] frame].size;
	NSLog(@"resolution = %fx%f", resolution.width, resolution.height);

	return self;
}


- (BOOL)windowShouldClose:(id)sender {
	[NSApp terminate:sender];
	return YES;
}

@end

