## Notes

### top loop
top loop is a NSURLConnectionDelegate to load ths main json doc from the server.

### detail loop
next level loops through the json data of images and downloads each using another NSURLConnectionDelegate

DBWindow.m - mainwindow
DBDataIndex.m - loads the json, requests 8 DBImageView objects
DBImageView.m - 1 ea download & display the image


NSWindowStyleMaskBorderless
NSWindowStyleMaskClosable
NSWindowStyleMaskFullScreen
NSWindowStyleMaskMiniaturizable
NSWindowStyleMaskResizable
NSWindowStyleMaskTitled
NSWindowStyleMaskUtilityWindow
NSWindowStyleMaskFullSizeContentView

  NSString *s0 = [[NSBundle mainBundle] pathForResource:@"avatar" ofType:@"png"]; 
  NSLog(@"s0 = %@", s0);
  NSString *wp = [[NSBundle mainBundle] pathForResource:@"[sender.urlBase substringFromIndex:11]" ofType:@"jpeg" inDirectory:@"gallery"];
  NSLog(@"wp = %@", wp);
  NSString *p1 = [[NSBundle mainBundle] pathForResource:@"" ofType:@""]; 
  NSLog(@"p1 = %@", p1);


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

