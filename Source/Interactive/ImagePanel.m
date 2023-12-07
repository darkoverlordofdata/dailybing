/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
// #import <Cocoa/Cocoa.h>
#import "ImagePanel.h"

@implementation ImagePanel {
    NSString *_url;
    NSString *_desc;
    NSString *_title;
    NSString *_urlBase;
    NSMutableData *_responseData;
}


- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data
{

    [[self initWithFrame:NSMakeRect(index*240, 0, 240, 135)] autorelease];

    _url = [[NSString alloc]initWithString:[data valueForKey:@"url"]];
    _desc = [[NSString alloc] initWithString:[data valueForKey:@"copyright"]];
    _title = [[NSString alloc] initWithString:[data valueForKey:@"title"]];
    _urlBase = [[NSString alloc] initWithString:[data valueForKey:@"urlbase"]];

    NSURL *url = [NSURL URLWithString:_url relativeToURL:[NSURL URLWithString:@"https://www.bing.com"]];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:60];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSString *gallery = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"Resources/gallery"];
    NSString *themes = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"Resources/themes"];
    [[NSFileManager defaultManager] createDirectoryAtPath:gallery attributes:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:themes attributes:nil];

    return self;

}

- (void)mouseDown:(NSEvent *)theEvent
{
    NSInteger clickCount = [theEvent clickCount];
    if (clickCount > 1) {
        [self onSelectImage];
    }
}


- (void)onSelectImage 
{
    NSData *url = [_url dataUsingEncoding:NSUTF8StringEncoding];
    NSData *desc = [_desc dataUsingEncoding:NSUTF8StringEncoding];
    NSData *title = [_title dataUsingEncoding:NSUTF8StringEncoding];

    NSString *wallpaper = [NSString stringWithFormat:@"%@/%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/gallery",
            [_urlBase substringFromIndex:11]]; 

    NSString *wallpaperPicture = [NSString stringWithFormat:@"%@/%@/%@%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/gallery",
            [_urlBase substringFromIndex:11],
            @".jpeg"];

    [[self image] saveAsJpegWithName: wallpaperPicture];

    [[NSFileManager defaultManager] createFileAtPath:wallpaper
            contents:nil
            attributes:nil];
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:wallpaper];
    [fh writeData:title];
    [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fh writeData:desc];
    [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *www = [NSString stringWithUTF8String:[url bytes]];
    NSString *fullurl = [NSString stringWithFormat:@"https://www.bing.com%@",www]; 
    [fh writeData:[fullurl dataUsingEncoding:NSUTF8StringEncoding]];
    [fh writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *now = [[NSDate date] description];
    [fh writeData:[now dataUsingEncoding:NSUTF8StringEncoding]];
    [fh closeFile];

    NSString *description = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/themes/wallpaper.description"];

    NSString *authorize = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/themes/wallpaper.authorize.jpg"];

    NSString *locked = [NSString stringWithFormat:@"%@/%@", 
            [[NSBundle mainBundle] bundlePath], 
            @"Resources/themes/wallpaper.locked.jpg"];

    [[self image] saveAsPngWithName: authorize];
    [[self image] saveAsPngWithName: locked];

    [[NSFileManager defaultManager] createFileAtPath:description
            contents:nil
            attributes:nil];
    NSFileHandle *fd = [NSFileHandle fileHandleForWritingAtPath:description];
    [fd writeData:title];
    [fd writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fd writeData:desc];
    [fd closeFile];


    // run external process to update the wallpaper location
    if ([[[[NSProcessInfo processInfo] environment] objectForKey:@"DESKTOP_SESSION"] isEqualToString:@"xfce"]) {
        [NSTask launchedTaskWithLaunchPath:@"/usr/local/bin/xfconf-query" 
                arguments:@[ 
                    @"/usr/local/bin/xfconf-query",
                    @"-c",
                    @"xfce4-desktop",
                    @"-p",
                    @"/backdrop/screen0/monitorHDMI-1/workspace0/last-image",
                    @"-s", 
                    [NSString stringWithFormat:@"%@", wallpaperPicture]
                    ]];

    } else if ([[NSFileManager defaultManager] fileExistsAtPath: @"/usr/local/bin/launch"]) {

        // helloSystem
        NSLog(@"/usr/local/bin/launch /System/Filer.app/Filer --set-wallpaper %@", [NSString stringWithFormat:@"%@", wallpaperPicture]);
        [NSTask launchedTaskWithLaunchPath:@"/usr/local/bin/launch" 
                arguments:@[ 
                    @"/usr/local/bin/launch",
                    @"/System/Filer.app/Filer",
                    @"--set-wallpaper", 
                    [NSString stringWithFormat:@"%@", wallpaperPicture]
                    ]];
    } else {

        // Vanilla Gnome
        [NSTask launchedTaskWithLaunchPath:@"/usr/bin/dconf" 
                arguments:@[ 
                    @"write", 
                    @"/org/gnome/desktop/background/picture-uri", 
                    [NSString stringWithFormat:@"\"file:\\%@\"", wallpaperPicture]
                    ]];
    }

}


#pragma mark - NSURLConnectionDelegate
//============================================================================

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [_responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"%@", error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSImage *img = [[NSImage alloc] initWithData: _responseData];

    [self setToolTip:_desc];
    [self setImage:img];

}



@end