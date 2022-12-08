/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"

//https://stackoverflow.com/questions/3038820/how-to-save-a-nsimage-as-a-new-file

@interface NSImage(saveAsJpegWithName)
- (void) saveAsJpegWithName:(NSString*) fileName;
@end

@implementation NSImage(saveAsJpegWithName)

- (void) saveAsJpegWithName:(NSString*) fileName
{
    // Cache the reduced image
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];        
}
@end

@interface NSImage(saveAsPngWithName)
- (void) saveAsPngWithName:(NSString*) fileName;
@end

@implementation NSImage(saveAsPngWithName)
- (void) saveAsPngWithName:(NSString*) fileName
{//
    // Cache the reduced image
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:imageProps];
    [imageData writeToFile:fileName atomically:NO];        
}

@end

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

  pictureBox1 = [[DBImageView alloc] initWithIndex: 0 data:image1];
  pictureBox2 = [[DBImageView alloc] initWithIndex: 1 data:image2];
  pictureBox3 = [[DBImageView alloc] initWithIndex: 2 data:image3];
  pictureBox4 = [[DBImageView alloc] initWithIndex: 3 data:image4];
  pictureBox5 = [[DBImageView alloc] initWithIndex: 4 data:image5];
  pictureBox6 = [[DBImageView alloc] initWithIndex: 5 data:image6];
  pictureBox7 = [[DBImageView alloc] initWithIndex: 6 data:image7];
  pictureBox8 = [[DBImageView alloc] initWithIndex: 7 data:image8];


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

  NSURL *baseUrl = [NSURL URLWithString:@"https://www.bing.com"];
  NSURL *url1 = [NSURL URLWithString:imageUrl1 relativeToURL:baseUrl];
  NSURL *url2 = [NSURL URLWithString:imageUrl2 relativeToURL:baseUrl];
  NSURL *url3 = [NSURL URLWithString:imageUrl3 relativeToURL:baseUrl];
  NSURL *url4 = [NSURL URLWithString:imageUrl4 relativeToURL:baseUrl];
  NSURL *url5 = [NSURL URLWithString:imageUrl5 relativeToURL:baseUrl];
  NSURL *url6 = [NSURL URLWithString:imageUrl6 relativeToURL:baseUrl];
  NSURL *url7 = [NSURL URLWithString:imageUrl7 relativeToURL:baseUrl];
  NSURL *url8 = [NSURL URLWithString:imageUrl8 relativeToURL:baseUrl];

  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  dispatch_async(queue, ^{ [self fetchUrl:url1 on:pictureBox1]; });
  dispatch_async(queue, ^{ [self fetchUrl:url2 on:pictureBox2]; });
  dispatch_async(queue, ^{ [self fetchUrl:url3 on:pictureBox3]; });
  dispatch_async(queue, ^{ [self fetchUrl:url4 on:pictureBox4]; });
  dispatch_async(queue, ^{ [self fetchUrl:url5 on:pictureBox5]; });
  dispatch_async(queue, ^{ [self fetchUrl:url6 on:pictureBox6]; });
  dispatch_async(queue, ^{ [self fetchUrl:url7 on:pictureBox7]; });
  dispatch_async(queue, ^{ [self fetchUrl:url8 on:pictureBox8]; });

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
  NSString *cwd = [[NSFileManager defaultManager] currentDirectoryPath];
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

  [img saveAsJpegWithName: wallpaperPicture];
  //https://www.oreilly.com/library/view/programming-in-objective-c/9780133756937/ch16lev1sec3.html
  [[NSFileManager defaultManager] createFileAtPath:wallpaper
        contents:nil
        attributes:nil];
  NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:wallpaper];
  [fh writeData:title];
  [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
  [fh writeData:desc];
  [fh closeFile];


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


  
  // run external process to update the wallpaper location
  // if ([@"ubuntu:GNOME" isEqualToString:desktop])
  //   [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dconf" 
  //             arguments:[NSArray arrayWithObjects:@"write", 
  //               @"/org/gnome/desktop/background/picture-uri", filename, nil]];

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

