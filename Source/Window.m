/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "Window.h"

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

// https://stackoverflow.com/questions/8332897/simple-http-request-in-gnusteps-objective-c-not-working
- (void) fetchUrl:(NSURL *)url on:(NSImageView *) view {

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

@end

