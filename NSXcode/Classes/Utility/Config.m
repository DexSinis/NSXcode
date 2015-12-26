//
//  Config.m
//  NSXcode
//
//  Created by DexSinis on 15/12/24.
//  Copyright © 2015年 DexSinis. All rights reserved.
//
#define NXSUserFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"NXSUser.data"]

#import "Config.h"
#import "NSXUser.h"
NSString * const kService = @"NSXcode";
NSString * const kAccount = @"account";
@implementation Config
+ (void)saveOwnAccount:(NSString *)account andPassword:(NSString *)password
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:kAccount];
    [userDefaults synchronize];
    
    [SSKeychain setPassword:password forService:kService account:account];
}
+ (NSArray *)getOwnAccountAndPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount];
    NSString *password = [SSKeychain passwordForService:kService account:account];
    
    if (account!=nil&&password!=nil) {return @[account, password];}
    return nil;
}
+ (void)saveOwnUser:(NSXUser *)User
{
    [NSKeyedArchiver archiveRootObject:User toFile:NXSUserFile];
}

+ (NSXUser *)getOwnUser
{
     NSXUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:NXSUserFile];
    return user;
}

//夜间状态
+ (void)saveWhetherNightMode:(BOOL)isNight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(isNight) forKey:@"mode"];
    [userDefaults synchronize];
}
+ (BOOL)getMode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [[userDefaults objectForKey:@"mode"] boolValue];
}

+ (void)clearCookie
{
    
//    NSArray *accountAndPassword = [Config getOwnAccountAndPassword];
//    [SSKeychain setPassword:accountAndPassword[1] forService:kService account:accountAndPassword[0]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:kAccount];
    [SSKeychain deletePasswordForService:kService account:account];
    [userDefaults removeObjectForKey:kAccount];
    NSXUser *user = nil;
    [NSKeyedArchiver archiveRootObject:user toFile:NXSUserFile];
    
}

@end
