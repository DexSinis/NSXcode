//
//  OSCNews.h
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

//#import "OSCBaseObject.h"

@interface NSXNews : NSObject

@property (nonatomic, assign) int newsID;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *body;

@end
