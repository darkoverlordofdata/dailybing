/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"
#import "NSImage+SaveAs.h"

@implementation DBWindow
- (instancetype)init {

	[NSApp setMainMenu:[[[NSMenu alloc] init] autorelease]];

	[[NSApp mainMenu] setSubmenu: [NSMenu new] forItem:[[NSApp mainMenu] addItemWithTitle: @"File" action:NULL keyEquivalent: @""]];
	[[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Get POD" action:@selector(fileGetPOD:) keyEquivalent:@""];
  [[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Preferences" action:NSSelectorFromString(@"") keyEquivalent:@""];
  [[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Open" action:@selector(fileOpen:) keyEquivalent:@""];
	[[[[NSApp mainMenu] itemArray][0] submenu] addItem:[NSMenuItem separatorItem]];
	[[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Save" action:@selector(fileSave:) keyEquivalent:@""];
  [[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Close" action:@selector(fileClose:) keyEquivalent:@""];
  [[[[NSApp mainMenu] itemArray][0] submenu] addItem:[NSMenuItem separatorItem]];
	[[[[NSApp mainMenu] itemArray][0] submenu] addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
   
	[[NSApp mainMenu] setSubmenu: [NSMenu new] forItem:[[NSApp mainMenu] addItemWithTitle: NSLocalizedString(@"Help", @"") action:NULL keyEquivalent: @""]];
	[[[[NSApp mainMenu] itemArray][1] submenu] addItemWithTitle:@"About" action:@selector(orderFrontStandardAboutPanel:) keyEquivalent:@"o"];


        
  // DBDataIndex *index = 
  [[DBDataIndex alloc] initWithParent:self];

  [super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
  [self setTitle:@"Bing Picture Of the Day"];

  [self setIsVisible:YES];

  NSSize resolution =  [[NSScreen mainScreen] frame].size;
  NSLog(@"resolution = %fx%f", resolution.width, resolution.height);

  return self;
}


- (BOOL)windowShouldClose:(id)sender {
  [NSApp terminate:sender];
  return YES;
}

- (void)fileClose:(id)sender {
  	NSLog(@"MainMenu/File/Close");
}

- (void)editUndo:(id)sender {
  	NSLog(@"MainMenu/Edit/Undo");
}

- (void)editRedo:(id)sender {
  	NSLog(@"MainMenu/Edit/Redo");
}

- (void)editCut:(id)sender {
  	NSLog(@"MainMenu/Edit/Cut");
}

- (void)editCopy:(id)sender {
  	NSLog(@"MainMenu/Edit/Copy");
}

- (void)editPaste:(id)sender {
  	NSLog(@"MainMenu/Edit/Paste");
}

- (void)editDelete:(id)sender {
  	NSLog(@"MainMenu/Edit/Delete");
}

- (void)editSelectAll:(id)sender {
  	NSLog(@"MainMenu/Edit/SelectAll");
}

@end

