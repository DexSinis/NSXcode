//
//  OSCUser.m
//  iosapp
//
//  Created by chenhaoxiang on 11/5/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "NSXAccount.h"

static NSString * const kID = @"uid";
static NSString * const kUserID = @"userid";
static NSString * const kLocation = @"location";
static NSString * const kFrom = @"from";
static NSString * const kName = @"name";
static NSString * const kFollowers = @"followers";
static NSString * const kFans = @"fans";
static NSString * const kScore = @"score";
static NSString * const kPortrait = @"portrait";
static NSString * const kFavoriteCount = @"favoritecount";
static NSString * const kExpertise = @"expertise";

@interface NSXAccount ()

@end


@implementation NSXAccount

//- (instancetype)initWithXML:(ONOXMLElement *)xml
//{
//    self = [super init];
//    if (!self) {return nil;}
////    // 有些API返回用<id>，有些地方用<userid>，这样写是为了简化处理
////    _userID = [[[xml firstChildWithTag:kID] numberValue] longLongValue] | [[[xml firstChildWithTag:kUserID] numberValue] longLongValue];
////    
////    // 理由同上
////    _location = [[[xml firstChildWithTag:kLocation] stringValue] copy];
////    if (!_location) {_location = [[[xml firstChildWithTag:kFrom] stringValue] copy];}
////    
////    _name = [[[xml firstChildWithTag:kName] stringValue] copy];
////    _followersCount = [[[xml firstChildWithTag:kFollowers] numberValue] intValue];
////    _fansCount = [[[xml firstChildWithTag:kFans] numberValue] intValue];
////    _score = [[[xml firstChildWithTag:kScore] numberValue] intValue];
////    _relationship = [[[xml firstChildWithTag:@"relation"] numberValue] intValue];
////    _portraitURL = [NSURL URLWithString:[[xml firstChildWithTag:kPortrait] stringValue]];
////    _favoriteCount = [[[xml firstChildWithTag:kFavoriteCount] numberValue] intValue];
////    
////    _gender             = [[[xml firstChildWithTag:@"gender"] stringValue] copy];
////    
////    _developPlatform    = [[[xml firstChildWithTag:@"devplatform"] stringValue] copy];
////    _expertise = [[[xml firstChildWithTag:kExpertise] stringValue] copy];
////    _joinTime = [NSDate dateFromString:[xml firstChildWithTag:@"jointime"].stringValue];
////    _latestOnlineTime = [NSDate dateFromString:[xml firstChildWithTag:@"latestonline"].stringValue];
//    
//    return self;
//}


- (BOOL)isEqual:(id)object
{
    if ([self class] == [object class]) {
//        return _userID == ((OSCUser *)object).userID;
    }
    
    return NO;
}


@end
