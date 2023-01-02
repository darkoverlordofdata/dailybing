/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"

@implementation DBImageView;

@synthesize url = _url;
@synthesize desc = _desc;
@synthesize title = _title;
@synthesize urlBase = _urlBase;
@synthesize resourcePath = _resourcePath;

- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data
{
    _resourcePath = [[NSBundle mainBundle] bundlePath]; 

    [[self initWithFrame:NSMakeRect(index*240, 0, 240, 135)] autorelease];

    _url = [[NSString alloc]initWithString:[data valueForKey:@"url"]];
    _desc = [[NSString alloc] initWithString:[data valueForKey:@"copyright"]];
    _title = [[NSString alloc] initWithString:[data valueForKey:@"title"]];
    _urlBase = [[NSString alloc] initWithString:[data valueForKey:@"urlbase"]];

    NSURL *url = [NSURL URLWithString:_url relativeToURL:[NSURL URLWithString:@"https://www.bing.com"]];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url                
        cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:60];

    [[NSURLConnection alloc] initWithRequest:request delegate:self];

    return self;

}

- (void)mouseDown:(NSEvent *)theEvent
{
    NSInteger clickCount = [theEvent clickCount];
    if (clickCount > 1) {
        [self onSelectImage];
    }
}

- (void)onSelectImage {
    NSData *url = [_url dataUsingEncoding:NSUTF8StringEncoding];
    NSData *desc = [_desc dataUsingEncoding:NSUTF8StringEncoding];
    NSData *title = [_title dataUsingEncoding:NSUTF8StringEncoding];

    NSArray *argv = [[NSProcessInfo processInfo] arguments];
    NSString *arg1 = (NSString*)argv[0];
    NSString *pwd = [arg1 stringByDeletingLastPathComponent];

//   NSString *s0 = [_resourcePath pathForResource:@"avatar" ofType:@"png"]; 
//   NSString *wp = [_resourcePath pathForResource:@"[sender.urlBase substringFromIndex:11]" ofType:@"jpeg" inDirectory:@"gallery"];


    NSString *gallery = [NSString stringWithFormat:@"%@/%@", pwd, @"Resources/gallery"];
    NSString *themes = [NSString stringWithFormat:@"%@/%@", pwd, @"Resources/themes"];
    [[NSFileManager defaultManager] createDirectoryAtPath:gallery attributes:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:themes attributes:nil];

    // copy base image & text to local gallery
    // this image is used for wallpaper
    NSString *wallpaper = [NSString stringWithFormat:@"%@/%@/%@", 
            pwd, 
            @"Resources/gallery",
            [_urlBase substringFromIndex:11]]; 

    NSString *wallpaperPicture = [NSString stringWithFormat:@"%@/%@/%@%@", 
            pwd, 
            @"Resources/gallery",
            [_urlBase substringFromIndex:11],
            @".jpeg"];

    [[self image] saveAsJpegWithName: wallpaperPicture];
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


    NSString *description = [NSString stringWithFormat:@"%@/%@", 
            pwd, 
            @"Resources/themes/wallpaper.description"];

    NSString *authorize = [NSString stringWithFormat:@"%@/%@", 
            pwd, 
            @"Resources/themes/wallpaper.authorize.jpg"];
    NSString *locked = [NSString stringWithFormat:@"%@/%@", 
            pwd, 
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
}

//NSURLConnectionDelegate protocol
//============================================================================

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc]init];
}
- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSImage *img = [[NSImage alloc] initWithData: responseData];
    [self setImage:img];

}



@end