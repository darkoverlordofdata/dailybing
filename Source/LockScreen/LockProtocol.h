#import <Cocoa/Cocoa.h>

@protocol LockProtocol
- (NSString*) name;
- (NSString*) description;
- (void) execute;
@end 
