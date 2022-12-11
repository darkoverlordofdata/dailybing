/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */
/*
 - (NSString *)pathForResource:(NSString *)name 
                       ofType:(NSString *)ext 
                  inDirectory:(NSString *)subpath;






*/

#import <Cocoa/Cocoa.h>
#import "ResourceManager.h"

@implementation ResourceManager

+ (id)sharedManager {
    static ResourceManager *sharedResourceManager = nil;
    @synchronized(self) {
        if (sharedResourceManager == nil)
            sharedResourceManager = [[self alloc] init];
    }
    return sharedResourceManager;
}

@synthesize resourcePath = _resourcePath;

- (instancetype)init {

    _resourcePath = [[NSBundle mainBundle] bundlePath]; 
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
    NSLog(@"%@", images);


    return self;
}

@end