/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"
#import "ResourceManager.h"
#import "DBDataIndex.h"

@class DBImageView;
@class ResourceManager;
@class DBDataIndex;

@interface DBWindow : NSWindow  {
  int fetchUrlCount;
  NSMutableData *responseData;
  NSMutableData *receivedData;
}

// - (NSImage*) resizeImage:(NSImage*)input by:(CGFloat)factor;
- (instancetype) init;
- (BOOL) windowShouldClose:(id)sender;
// - (void) fetchUrl:(NSURL *)url on:(DBImageView *) view;
// - (void) onSelect:(DBImageView*)sender;



@end
