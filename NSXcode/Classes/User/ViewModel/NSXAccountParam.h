//
//  NSXAccountParam.h
//  NSXcode
//
//  Created by DexSinis on 15/11/30.
//  Copyright © 2015年 DexSinis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSXAccount.h"
@interface NSXAccountParam : NSXAccount
@property (nonatomic, readwrite, copy) NSString *accountName;
@property (nonatomic, readwrite, copy) NSString *password;
@property (nonatomic, readonly, copy) NSString *userId;
@end
