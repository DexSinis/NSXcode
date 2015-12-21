//
//  OSCMyInfo.m
//  iosapp
//
//  Created by chenhaoxiang on 2/4/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "OSCMyInfo.h"

@implementation OSCMyInfo

//- (instancetype)initWithXML:(ONOXMLElement *)xml
//{
//    self = [super init];
//    if (self) {
//        _name               = [[[xml firstChildWithTag:@"name"] stringValue] copy];
//        _portraitURL        = [NSURL URLWithString:[[xml firstChildWithTag:@"portrait"] stringValue]];
//        _hometown           = [[[xml firstChildWithTag:@"from"] stringValue] copy];
//        _developPlatform    = [[[xml firstChildWithTag:@"devplatform"] stringValue] copy];
//        _expertise          = [[[xml firstChildWithTag:@"expertise"] stringValue] copy];
//        _joinTime           = [NSDate dateFromString:[xml firstChildWithTag:@"joinTime"].stringValue];
//        
//        _gender             = [[[xml firstChildWithTag:@"gender"] numberValue] intValue];
//        _favoriteCount      = [[[xml firstChildWithTag:@"favoritecount"] numberValue] intValue];
//        _fansCount          = [[[xml firstChildWithTag:@"fans"] numberValue] intValue];
//        _followersCount     = [[[xml firstChildWithTag:@"followers"] numberValue] intValue];
//        _score              = [[[xml firstChildWithTag:@"score"] numberValue] intValue];
//    }
//    
//    return self;
//}

- (void)setDetailInformationJointime:(NSDate *)jointime
                         andHometown:(NSString *)hometown
                  andDevelopPlatform:(NSString *)developPlatform
                        andExpertise:(NSString *)expertise
{
    _joinTime = jointime;
    _hometown = hometown;
    _developPlatform = developPlatform;
    _expertise = expertise;
}

@end
