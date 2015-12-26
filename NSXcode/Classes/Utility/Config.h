//
//  Config.h
//  NSXcode
//
//  Created by DexSinis on 15/12/24.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSKeychain.h>
@class NSXUser;
@interface Config : NSObject
+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password;
+ (NSArray *)getOwnAccountAndPassword;
+ (void)saveOwnUser:(NSXUser *)User;
+ (NSXUser *)getOwnUser;
+ (void)saveWhetherNightMode:(BOOL)isNight;
+ (BOOL)getMode;
+ (void)clearCookie;

@end
