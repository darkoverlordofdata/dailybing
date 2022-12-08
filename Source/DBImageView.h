/* 
 * Copyright (c) 2022 bruce davidson <darkoverlordofdata@gmail.com>.
 *
 * BSD 2-Clause License
 */

#import <Cocoa/Cocoa.h>
#import "DBWindow.h"

@class DBWindow;


@interface DBImageView : NSImageView;

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *desc; //copyright
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *urlBase;

- (instancetype)initWithIndex:(int)index data:(NSDictionary *) data;

@end