/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBImageView.h"

@class DBImageView;

@interface DBWindow : NSWindow {
  DBImageView *pictureBox1;
  DBImageView *pictureBox2;
  DBImageView *pictureBox3;
  DBImageView *pictureBox4;
  DBImageView *pictureBox5;
  DBImageView *pictureBox6;
  DBImageView *pictureBox7;
  DBImageView *pictureBox8;


}

- (instancetype)init;
- (BOOL)windowShouldClose:(id)sender;
- (void) fetchUrl:(NSURL *)url on:(DBImageView *) view;
- (void) onSelect:(DBImageView*)sender;
// - (void)URLResourceDidFinishLoading:(NSURL *)sender;



@end
