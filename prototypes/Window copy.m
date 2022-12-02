#import <Cocoa/Cocoa.h>
#import "Window.h"

#define LOCAL "/home/darko/Documents/GitHub/DailyBing/Resources/%@"

// https://stackoverflow.com/questions/8332897/simple-http-request-in-gnusteps-objective-c-not-working
//https://sudonull.com/post/138081-US-Visa-My-First-iPhone-App

@implementation Window
- (instancetype)init {

  pictureBox1 = [[[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 240, 135)] autorelease];
  pictureBox2 = [[[NSImageView alloc] initWithFrame:NSMakeRect(240, 0, 240, 135)] autorelease];
  pictureBox3 = [[[NSImageView alloc] initWithFrame:NSMakeRect(480, 0, 240, 135)] autorelease];
  pictureBox4 = [[[NSImageView alloc] initWithFrame:NSMakeRect(720, 0, 240, 135)] autorelease];
  pictureBox5 = [[[NSImageView alloc] initWithFrame:NSMakeRect(960, 0, 240, 135)] autorelease];
  pictureBox6 = [[[NSImageView alloc] initWithFrame:NSMakeRect(1200, 0, 240, 135)] autorelease];
  pictureBox7 = [[[NSImageView alloc] initWithFrame:NSMakeRect(1440, 0, 240, 135)] autorelease];
  pictureBox8 = [[[NSImageView alloc] initWithFrame:NSMakeRect(1680, 0, 240, 135)] autorelease];

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

  NSURL *url1 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.RovinjCroatia_EN-US9834093615_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url2 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.HeronGiving_EN-US9774285216_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url3 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.RedPlanetDay_EN-US9693219784_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url4 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.Cecropia_EN-US9602789937_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url5 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.OliveTreeDay_EN-US9460125670_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url6 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.MonksMound_EN-US9323884241_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url7 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.CranberryBog_EN-US4145520322_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];
  NSURL *url8 = [NSURL URLWithString:@"https://www.bing.com/th?id=OHR.HelianthusAnnuus_EN-US9168789034_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp"];

  // map the urls back to an index number for async display
  map = @{[url1 absoluteString]: [NSNumber numberWithInt:1], 
          [url2 absoluteString]: [NSNumber numberWithInt:2], 
          [url3 absoluteString]: [NSNumber numberWithInt:3], 
          [url4 absoluteString]: [NSNumber numberWithInt:4], 
          [url5 absoluteString]: [NSNumber numberWithInt:5], 
          [url6 absoluteString]: [NSNumber numberWithInt:6], 
          [url7 absoluteString]: [NSNumber numberWithInt:7], 
          [url8 absoluteString]: [NSNumber numberWithInt:8]};

  [url1 loadResourceDataNotifyingClient:self usingCache:YES];
  [url2 loadResourceDataNotifyingClient:self usingCache:YES];


  // NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:url1                
  //     cachePolicy:NSURLRequestReloadIgnoringCacheData  
  //         timeoutInterval:60]; 
  // NSURLResponse *response1; 
  // NSError *error1 =  [[NSError alloc] init]; 

  // NSData *dat1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response1 error:&error1]; 
  // NSImage *img1 = [[NSImage alloc] initWithData: dat1];

  // NSURLRequest *request2 = [[NSURLRequest alloc] initWithURL:url2                
  //     cachePolicy:NSURLRequestReloadIgnoringCacheData  
  //         timeoutInterval:60]; 
  // NSURLResponse *response2; 
  // NSError *error2 =  [[NSError alloc] init]; 

  // NSData *dat2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:&response2 error:&error2]; 
  // NSImage *img2 = [[NSImage alloc] initWithData: dat2];


  NSImage *img3 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"03.jpeg"]];
  NSImage *img4 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"04.jpeg"]];
  NSImage *img5 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"05.jpeg"]];
  NSImage *img6 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"06.jpeg"]];
  NSImage *img7 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"07.jpeg"]];
  NSImage *img8 = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@LOCAL, @"08.jpeg"]];
  

  // [pictureBox1 setImage:img1];
  // [pictureBox2 setImage:img2];
  [pictureBox3 setImage:img3];
  [pictureBox4 setImage:img4];
  [pictureBox5 setImage:img5];
  [pictureBox6 setImage:img6];
  [pictureBox7 setImage:img7];
  [pictureBox8 setImage:img8];

  return self;
}

- (BOOL)windowShouldClose:(id)sender {
  [NSApp terminate:sender];
  return YES;
}

- (void)URLResourceDidFinishLoading:(NSURL *)sender {

  NSString *s = [sender absoluteString];
  NSNumber *index = map[[sender absoluteString]];

  NSLog(@"URLResourceDidFinishLoading %d %@", [index intValue], s);
  NSData *dat = [sender resourceDataUsingCache:YES];
  NSImage *img = [[NSImage alloc] initWithData: dat];

  switch([index intValue]) {
    case 1:
      // [pictureBox1 setImage:img];
      break;

    case 2:
      [pictureBox2 setImage:img];
      break;
  }

}


@end

