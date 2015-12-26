//
//  OSCUser.h
//  iosapp
//
//  Created by chenhaoxiangs on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//
#import <MJExtension/MJExtension.h>

@interface NSXUser : NSObject

@property (nonatomic, readwrite, assign) NSString* userID;
@property (nonatomic, readonly, copy) NSString *location;
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readonly, assign) int followersCount;
@property (nonatomic, readonly, assign) int fansCount;
@property (nonatomic, readonly, assign) int score;
@property (nonatomic, readonly, assign) int favoriteCount;
@property (nonatomic, assign)           int relationship;
@property (nonatomic, readwrite, strong) NSURL *portraitURL;
@property (nonatomic, readonly, copy) NSString *gender;
@property (nonatomic, readonly, copy) NSString *developPlatform;
@property (nonatomic, readonly, copy) NSString *expertise;
@property (nonatomic, readonly, strong) NSDate *joinTime;
@property (nonatomic, readonly, strong) NSDate *latestOnlineTime;
@property (nonatomic, readwrite, copy) NSString *pinyin; //拼音
@property (nonatomic, readwrite, copy) NSString *pinyinFirst; //拼音首字母
@property (nonatomic, readonly, copy) NSString *hometown;



@end
