//
//  OSCMyInfo.h
//  iosapp
//
//  Created by chenhaoxiang on 2/4/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

//#import "OSCBaseObject.h"

@interface OSCMyInfo : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, strong) NSURL *portraitURL;
@property (nonatomic, readonly, assign) int favoriteCount;
@property (nonatomic, readonly, assign) int fansCount;
@property (nonatomic, readonly, assign) int followersCount;
@property (nonatomic, readonly, assign) int score;
@property (nonatomic, readonly, assign) int gender;
@property (nonatomic, readonly, strong) NSDate *joinTime;
@property (nonatomic, readonly, copy) NSString *developPlatform;
@property (nonatomic, readonly, copy) NSString *expertise;
@property (nonatomic, readonly, copy) NSString *hometown;

- (void)setDetailInformationJointime:(NSString *)jointime andHometown:(NSString *)hometown andDevelopPlatform:(NSString *)developPlatform andExpertise:(NSString *)expertise;

@end
