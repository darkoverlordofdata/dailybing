/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>


@interface Window : NSWindow {
  NSImageView *pictureBox1;
  NSImageView *pictureBox2;
  NSImageView *pictureBox3;
  NSImageView *pictureBox4;
  NSImageView *pictureBox5;
  NSImageView *pictureBox6;
  NSImageView *pictureBox7;
  NSImageView *pictureBox8;


}
- (instancetype)init;
- (BOOL)windowShouldClose:(id)sender;
- (void) fetchUrl:(NSURL *)url on:(NSImageView *) view;
// - (void)URLResourceDidFinishLoading:(NSURL *)sender;



@end
