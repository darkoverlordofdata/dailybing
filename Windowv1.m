#import <Cocoa/Cocoa.h>
#import "./NSPatch/NSPatch.h"

#import "Window.h"

@implementation Window
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
  

  pictureBox1 = [[[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 240, 135)] autorelease];
  pictureBox2 = [[[NSImageView alloc] initWithFrame:NSMakeRect(240, 0, 240, 135)] autorelease];

  [super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
  [self setTitle:@"Bing Picture Of the Day"];
  [[self contentView] addSubview:pictureBox1];
  [[self contentView] addSubview:pictureBox2];
  [self setIsVisible:YES];
  return self;
}

- (BOOL)windowShouldClose:(id)sender {
  [NSApp terminate:sender];
  return YES;
}

- (void)fileNew:(id)sender {
  	NSLog(@"MainMenu/File/New");
}

- (void)fileOpen:(id)sender {
  	NSLog(@"MainMenu/File/New");
}

- (void)fileGetPOD:(id)sender {
      NSLog(@"MainMenu/File/GetPOD");

      // https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US
      
      NSString *bingUrl= @"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US";
      NSURL *url = [NSURL URLWithString:bingUrl]; 
      NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  
          timeoutInterval:60]; 

      NSURLResponse *response = nil; 
      NSError *error = nil; 
      NSError *jsonErr = nil; 

      NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 

      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];

      NSArray *images = [json valueForKey:@"images"];

      // NSDictionary *image = [images objectAtIndex: 0];
      // NSString *imageUrl = [image valueForKey:@"url"];
      // NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
      // NSURL *fullUrl = [NSURL URLWithString:imageUrl relativeToURL:baseUrl];



      // NSImage *img1 = [[NSImage alloc] initWithContentsOfURL:fullUrl];
      // [pictureBox1 setImage:img1];
      [pictureBox1 setImage:[self getImageAt:0 from:images]];
      [pictureBox1 setImageFrameStyle:(NSImageFrameNone)];

      // NSImage *img2 = [[NSImage alloc] initWithContentsOfURL:fullUrl];
      // [pictureBox2 setImage:img2];
      [pictureBox2 setImage:[self getImageAt:1 from:images]];
      [pictureBox2 setImageFrameStyle:(NSImageFrameNone)];

}

- (NSImage*)getImageAt:(int)index from:(NSArray*)images {
      NSDictionary *image = [images objectAtIndex: index];
      NSString *imageUrl = [image valueForKey:@"url"];
      NSLog(@"imageUrl = %@", imageUrl);
      // NSString *name = [image valueForKey:@"copyright"];
      // NSString *title = [image valueForKey:@"title"];
      NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
      NSURL *fullUrl = [NSURL URLWithString:imageUrl relativeToURL:baseUrl];
      NSLog(@"fullUrl = %@", fullUrl.absoluteString);
      return [[NSImage alloc] initWithContentsOfURL:fullUrl];
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

