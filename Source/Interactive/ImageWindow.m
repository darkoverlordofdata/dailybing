/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */
#import "ImageWindow.h"
#import "ImageContainer.h"

@implementation ImageWindow {
  AppDelegate* _app;

}
- (instancetype)initWithParent: (AppDelegate*) app
{
    
	_app = app;
	[[ImageContainer alloc] initWithParent:self];

	[super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
	[self setTitle:@"Bing Picture Of the Day"];

#if OBJC_RUNTIME==21
		[self setIsVisible:YES];
#else
  		[self orderFrontRegardless];
#endif
	// if ([NSWindow instancesRespondToSelector:@selector(setIsVisible:)]) {
	// 	// Latest version on Linux has fixed this
	// 	[self setIsVisible:YES];
	// } else {
	// 	// Latest version on FreeBSD doesn't have the fix yet...
  	// 	[self orderFrontRegardless];
	// }
	return self;
}


- (BOOL)windowShouldClose:(id)sender {
	[NSApp terminate:sender];
	return YES;
}

@end

