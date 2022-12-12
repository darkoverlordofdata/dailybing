/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"
#import "NSImage+SaveAs.h"

#define NUM_PICS 8

@implementation DBWindow
- (instancetype)init {

  // NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageCache" ofType:@"plist"]; 
  // NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath]; 
  // dict[@"Name"] = @"Frodo";
  // NSLog(@"%@", dict);
  // [dict writeToFile:plistPath atomically:YES];
  // for (NSDictionary *d in a)

  // NSString *s1 = [[ResourceManager sharedManager] resourcePath];
  // NSString *s2 = [[NSBundle mainBundle] pathForResource:@"avatar" ofType:@"png"]; 

  // NSLog(@"s1 = %@", s1);
  // NSLog(@"s2 = %@", s2);

  

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

  NSMutableArray *picbox = [NSMutableArray arrayWithCapacity:NUM_PICS];
  NSMutableArray *imageN = [NSMutableArray arrayWithCapacity:NUM_PICS];
  NSMutableArray *imageUrlN = [NSMutableArray arrayWithCapacity:NUM_PICS];
  NSMutableArray *urlN = [NSMutableArray arrayWithCapacity:NUM_PICS];

  for(int i = 0; i<NUM_PICS; i++){
      imageN[i] = [images objectAtIndex: i];
      imageUrlN[i] = [imageN[i] valueForKey:@"url"];
      picbox[i] =  [[DBImageView alloc] initWithIndex: i data:imageN[i]];
  }

  [super initWithContentRect:NSMakeRect(0, 0, 1920, 140) styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:NO];
  [self setTitle:@"Bing Picture Of the Day"];
  for(int i = 0; i<NUM_PICS; i++){
    [[self contentView] addSubview:picbox[i]];
  }

  [self setIsVisible:YES];

  NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
  for(int i = 0; i<NUM_PICS; i++){
      urlN[i] = [NSURL URLWithString:imageUrlN[i] relativeToURL:baseUrl];
  }

  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  for(int i = 0; i<NUM_PICS; i++){
    dispatch_async(queue, ^{ [self fetchUrl:urlN[i] on:picbox[i]]; });
  }


  NSSize resolution =  [[NSScreen mainScreen] frame].size;
  NSLog(@"resolution = %fx%f", resolution.width, resolution.height);

  return self;
}

/*
 * do the real work:
 * create & set images for wallpaper and lock-screen
 */
- (void) onSelect:(DBImageView*)sender {

  NSLog(@"Selected!!!");
  NSData *url = [sender.url dataUsingEncoding:NSUTF8StringEncoding];
  NSData *desc = [sender.desc dataUsingEncoding:NSUTF8StringEncoding];
  NSData *title = [sender.title dataUsingEncoding:NSUTF8StringEncoding];

  NSArray *argv = [[NSProcessInfo processInfo] arguments];
  NSLog(@"argv[0] = %@", argv[0]);
  NSString *arg1 = (NSString*)argv[0];
  NSString *cwd = [arg1 stringByDeletingLastPathComponent];
  // NSLog(@"path = %@", path);

  // // NSString *cwd = [NSString stringWithUTF8String:argv[0]];
  // NSString *cwd = [[NSFileManager defaultManager] currentDirectoryPath];
  NSLog(@"CWD = %@", cwd);

  NSString *gallery = [NSString stringWithFormat:@"%@/%@", cwd, @"Resources/gallery"];
  NSString *themes = [NSString stringWithFormat:@"%@/%@", cwd, @"Resources/themes"];
  [[NSFileManager defaultManager] createDirectoryAtPath:gallery attributes:nil];
  [[NSFileManager defaultManager] createDirectoryAtPath:themes attributes:nil];

/** 
 * OnClick handler
 *
 * resize cached image and copy to 'lockscreen.png'
 * copy resized cache image and darken by 15% and save as 'authscreen.png'
 * write desc and title to text file 'wallpaper.themes'
 * send message to desktop manager with new wallpaper
 */

  NSImage * img = [sender image];

  //    # Ubuntu Gnome
  // elif os.environ['XDG_CURRENT_DESKTOP'] == 'ubuntu:GNOME':
  //     os.system(f'dconf write /org/gnome/desktop/background/picture-uri "\'file://{LOCAL}/gallery/{urlbase}.jpeg\'"')

  NSDictionary *env = [[NSProcessInfo processInfo] environment];
  NSString *desktop = env[@"ORIGINAL_XDG_CURRENT_DESKTOP"];
  NSString *home = env[@"HOME"];

  // copy base image & text to local gallery
  // this image is used for wallpaper
  NSString *wallpaper = [NSString stringWithFormat:@"%@/%@/%@", 
          cwd, 
          @"Resources/gallery",
          [sender.urlBase substringFromIndex:11]]; 
  NSLog(@"wallpaper = %@", wallpaper);
  NSString *wallpaperPicture = [NSString stringWithFormat:@"%@/%@/%@%@", 
          cwd, 
          @"Resources/gallery",
          [sender.urlBase substringFromIndex:11],
          @".jpeg"];

  NSLog(@"wallpaperPicture = %@", wallpaperPicture);

  NSString *s0 = [[NSBundle mainBundle] pathForResource:@"avatar" ofType:@"png"]; 
  NSLog(@"s0 = %@", s0);
  NSString *wp = [[NSBundle mainBundle] pathForResource:@"[sender.urlBase substringFromIndex:11]" ofType:@"jpeg" inDirectory:@"gallery"];
  NSLog(@"wp = %@", wp);
  NSString *p1 = [[NSBundle mainBundle] pathForResource:@"" ofType:@""]; 
  NSLog(@"p1 = %@", p1);

  [img saveAsJpegWithName: wallpaperPicture];
  //https://www.oreilly.com/library/view/programming-in-objective-c/9780133756937/ch16lev1sec3.html
  [[NSFileManager defaultManager] createFileAtPath:wallpaper
        contents:nil
        attributes:nil];
  NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:wallpaper];
  [fh writeData:title];
  [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [fh writeData:desc];
  [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
  // [fh writeData:url];
  NSString *www = [NSString stringWithUTF8String:[url bytes]];
  NSString *fullurl = [NSString stringWithFormat:@"https://www.bing.com%@",www]; 
  [fh writeData:[fullurl dataUsingEncoding:NSUTF8StringEncoding]];
  [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
  NSString *now = [[NSDate date] description];
  [fh writeData:[now dataUsingEncoding:NSUTF8StringEncoding]];
  [fh closeFile];

  // run external process to update the wallpaper location
  // if ([@"ubuntu:GNOME" isEqualToString:desktop])

    [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dconf" 
              arguments:@[ 
                @"write", 
                @"/org/gnome/desktop/background/picture-uri", 
                [NSString stringWithFormat:@"\"file:\\%@\"", wallpaperPicture]
                ]];

              // arguments:[NSArray arrayWithObjects:@"write", 
              //   @"/org/gnome/desktop/background/picture-uri", wallpaperPicture, nil]];

  // NSImage *img2 = [self resizeImage:img by:0.5];

  // create NSBitmapImageRep from NSImage
  // use the rep to scale and darken for lock screen
  // also, copy the associated text file
  // NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[img TIFFRepresentation]];
  // NSSize imageSize = [img size];
  // CGFloat y = imageSize.height - 100.0;
  // NSColor* color = [imageRep colorAtX:100.0 y:y];
  // [imageRep release];

  NSString *description = [NSString stringWithFormat:@"%@/%@", 
          cwd, 
          @"Resources/themes/wallpaper.description"];

  NSString *authorize = [NSString stringWithFormat:@"%@/%@", 
          cwd, 
          @"Resources/themes/wallpaper.authorize.jpg"];
  NSString *locked = [NSString stringWithFormat:@"%@/%@", 
          cwd, 
          @"Resources/themes/wallpaper.locked.jpg"];

  [img saveAsPngWithName: authorize];
  [img saveAsPngWithName: locked];

  [[NSFileManager defaultManager] createFileAtPath:description
        contents:nil
        attributes:nil];
  NSFileHandle *fd = [NSFileHandle fileHandleForWritingAtPath:description];
  [fd writeData:title];
  [fd writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [fd writeData:desc];
  [fd closeFile];


  

  NSLog(@"%@", sender.url);
  NSLog(@"%@", sender.desc);
  NSLog(@"%@", sender.title);



}

-(NSImage*)resizeImage:(NSImage*)input by:(CGFloat)factor
{    
    NSSize size = NSZeroSize;      
    size.width = input.size.width*factor;
    size.height = input.size.height*factor; 

    NSImage *ret = [[NSImage alloc] initWithSize:size];
    [ret lockFocus];
    NSAffineTransform *transform = [NSAffineTransform transform];
    [transform scaleBy:factor];  
    [transform concat]; 
    [input drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];    
    [ret unlockFocus];        

    return [ret autorelease];
}


// https://stackoverflow.com/questions/8332897/simple-http-request-in-gnusteps-objective-c-not-working
- (void) fetchUrl:(NSURL *)url on:(DBImageView *) view {

    fetchUrlCount++;
    NSLog(@"fetch %i %@", fetchUrlCount, [url absoluteString]);

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  
            timeoutInterval:60.0]; 
    NSURLResponse *response; 
    NSError *error =  [[NSError alloc] init]; 

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 
    NSImage *img = [[NSImage alloc] initWithData: data];
    [view setImage:img];
    fetchUrlCount--;

    if (fetchUrlCount < 1) [self onFetchUrlComplete];
}

- (void) onFetchUrlComplete {
    NSLog(@"All Fetch Complete %i",fetchUrlCount);
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

