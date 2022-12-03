/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
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
  
  // pictureBox1 = [[[DBImageView alloc] initWithFrame:NSMakeRect(0, 0, 240, 135)] autorelease];
  pictureBox2 = [[[DBImageView alloc] initWithFrame:NSMakeRect(240, 0, 240, 135)] autorelease];
  pictureBox3 = [[[DBImageView alloc] initWithFrame:NSMakeRect(480, 0, 240, 135)] autorelease];
  pictureBox4 = [[[DBImageView alloc] initWithFrame:NSMakeRect(720, 0, 240, 135)] autorelease];
  pictureBox5 = [[[DBImageView alloc] initWithFrame:NSMakeRect(960, 0, 240, 135)] autorelease];
  pictureBox6 = [[[DBImageView alloc] initWithFrame:NSMakeRect(1200, 0, 240, 135)] autorelease];
  pictureBox7 = [[[DBImageView alloc] initWithFrame:NSMakeRect(1440, 0, 240, 135)] autorelease];
  pictureBox8 = [[[DBImageView alloc] initWithFrame:NSMakeRect(1680, 0, 240, 135)] autorelease];

  [super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
  [self setTitle:@"Bing Picture Of the Day"];
  [[self contentView] addSubview:pictureBox1];
  [[self contentView] addSubview:pictureBox2];
  [[self contentView] addSubview:pictureBox3];
  [[self contentView] addSubview:pictureBox4];
  [[self contentView] addSubview:pictureBox5];
  [[self contentView] addSubview:pictureBox6];
  [[self contentView] addSubview:pictureBox7];
  [[self contentView] addSubview:pictureBox8];
  [self setIsVisible:YES];

  NSArray *numList = @[[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0], [NSNumber numberWithInt: 0]];


  NSString *bingUrl= @"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US";
  NSURL *url = [NSURL URLWithString:bingUrl]; 
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:60]; 

  NSURLResponse *response = [[NSURLResponse alloc] init];
  NSError *error = [[NSError alloc] init]; 
  NSError *jsonErr = [[NSError alloc] init]; 

  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 

  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErr];
  NSArray *images = [json valueForKey:@"images"];


  NSDictionary *image1 = [images objectAtIndex: 0];
  NSString *imageUrl1 = [image1 valueForKey:@"url"];
  NSDictionary *image2 = [images objectAtIndex: 1];
  NSString *imageUrl2 = [image2 valueForKey:@"url"];
  NSDictionary *image3 = [images objectAtIndex: 2];
  NSString *imageUrl3 = [image3 valueForKey:@"url"];
  NSDictionary *image4 = [images objectAtIndex: 3];
  NSString *imageUrl4 = [image4 valueForKey:@"url"];
  NSDictionary *image5 = [images objectAtIndex: 4];
  NSString *imageUrl5 = [image5 valueForKey:@"url"];
  NSDictionary *image6 = [images objectAtIndex: 5];
  NSString *imageUrl6 = [image6 valueForKey:@"url"];
  NSDictionary *image7 = [images objectAtIndex: 6];
  NSString *imageUrl7 = [image7 valueForKey:@"url"];
  NSDictionary *image8 = [images objectAtIndex: 7];
  NSString *imageUrl8 = [image8 valueForKey:@"url"];

  NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
  NSURL *url1 = [NSURL URLWithString:imageUrl1 relativeToURL:baseUrl];
  NSURL *url2 = [NSURL URLWithString:imageUrl2 relativeToURL:baseUrl];
  NSURL *url3 = [NSURL URLWithString:imageUrl3 relativeToURL:baseUrl];
  NSURL *url4 = [NSURL URLWithString:imageUrl4 relativeToURL:baseUrl];
  NSURL *url5 = [NSURL URLWithString:imageUrl5 relativeToURL:baseUrl];
  NSURL *url6 = [NSURL URLWithString:imageUrl6 relativeToURL:baseUrl];
  NSURL *url7 = [NSURL URLWithString:imageUrl7 relativeToURL:baseUrl];
  NSURL *url8 = [NSURL URLWithString:imageUrl8 relativeToURL:baseUrl];

  // NSLog(@"url1 = %@", url1);
  // NSLog(@"url2 = %@", url2);
  // NSLog(@"url3 = %@", url3);
  // NSLog(@"url4 = %@", url4);
  // NSLog(@"url5 = %@", url5);
  // NSLog(@"url6 = %@", url6);
  // NSLog(@"url7 = %@", url7);
  // NSLog(@"url8 = %@", url8);

  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  dispatch_async(queue, ^{ [self fetchUrl:url1 on:pictureBox1]; });
  dispatch_async(queue, ^{ [self fetchUrl:url2 on:pictureBox2]; });
  dispatch_async(queue, ^{ [self fetchUrl:url3 on:pictureBox3]; });
  dispatch_async(queue, ^{ [self fetchUrl:url4 on:pictureBox4]; });
  dispatch_async(queue, ^{ [self fetchUrl:url5 on:pictureBox5]; });
  dispatch_async(queue, ^{ [self fetchUrl:url6 on:pictureBox6]; });
  dispatch_async(queue, ^{ [self fetchUrl:url7 on:pictureBox7]; });
  dispatch_async(queue, ^{ [self fetchUrl:url8 on:pictureBox8]; });
  return self;
}

- (void) onSelect:(DBImageView*)sender {
  NSLog(@"Selected!!!");
}

// https://stackoverflow.com/questions/8332897/simple-http-request-in-gnusteps-objective-c-not-working
- (void) fetchUrl:(NSURL *)url on:(DBImageView *) view {

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  
            timeoutInterval:60]; 
    NSURLResponse *response; 
    NSError *error =  [[NSError alloc] init]; 

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 
    NSImage *img = [[NSImage alloc] initWithData: data];
    [view setImage:img];

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

