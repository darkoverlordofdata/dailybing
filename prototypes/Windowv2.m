#import <Cocoa/Cocoa.h>
#import "./NSPatch/NSPatch.h"

#import "DBWindow.h"

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
      
      NSString *bingUrl= @"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US";
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



      NSDictionary *image1 = [images objectAtIndex: 1];
      NSString *imageUrl1 = [image1 valueForKey:@"url"];
      NSURL *baseUrl1 = [NSURL URLWithString:@"https://www.bing.com"];
      NSURL *fullUrl1 = [NSURL URLWithString:imageUrl1 relativeToURL:baseUrl1];
      NSLog(@"fullUrl1 = %@", fullUrl1);

      NSDictionary *image = [images objectAtIndex: 0];
      NSString *imageUrl = [image valueForKey:@"url"];
      NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
      NSURL *fullUrl = [NSURL URLWithString:imageUrl relativeToURL:baseUrl];
      NSLog(@"fullUrl = %@", fullUrl);

      NSURL url1 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.RedPlanetDay_EN-US9693219784_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
      NSURL url2 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.HeronGiving_EN-US9774285216_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];

      NSImage *img1 = [[NSImage alloc] initWithContentsOfURL:fullUrl];
      NSImage *img2 = [[NSImage alloc] initWithContentsOfURL:fullUrl1];

      [pictureBox2 setImage:img2];
      [pictureBox1 setImage:img1];

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

