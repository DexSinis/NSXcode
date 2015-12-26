//
//  OSCUser.h
//  iosapp
//
//  Created by chenhaoxiangs on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//


@interface NSXAccount : NSObject

@property (nonatomic, readwrite, copy) NSString *accountName;
@property (nonatomic, readwrite, copy) NSString *password;
@property (nonatomic, readonly, copy) NSString *userID;

@end
