#import "TextField.h"

@implementation TextField {
  NSTextField* _textField;
}

- (instancetype)init 
{
  _textField = [super initWithFrame:NSMakeRect(60, 80, 800, 64)] autorelease];

  [_textField setFont:[NSFont fontWithName:@"SanFranciscoDisplay-Medium"
                                        size:64]];
  [_textField setBezeled:NO];
  [_textField setBezelStyle:NSTextFieldRoundedBezel];
  [_textField setDrawsBackground:NO];
  [_textField setEditable:NO];
  [_textField setSelectable:NO];
  [_textField setHidden:NO];
  [_textField setTextColor:[NSColor whiteColor]];

}



@end