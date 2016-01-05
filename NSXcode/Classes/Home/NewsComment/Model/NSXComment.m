//
//  Comment.m
//  NSXcode
//
//  Created by DexSinis on 16/1/5.
//  Copyright © 2016年 DexSinis. All rights reserved.
//

#import "Constant.h"
#import "NSXComment.h"

@implementation NSXComment


-(instancetype)initWithDict:(NSDictionary *)dic{
    
    if (self = [super init]) {
        NSString *string =dic[@"f"];
        NSRange rang =[string rangeOfString:@"["];
        
        self.address =[string substringToIndex:rang.location];
        
        self.comment =dic[@"b"];
        
        rang =[string rangeOfString:@"["];
        NSInteger start = rang.location;
        rang =[string rangeOfString:@"]"];
        NSInteger end = rang.location;
        
        self.username = [string substringWithRange:NSMakeRange(start+1, end - start-1)];
        self.timeString =dic[@"t"];
        
    }
    return self;
    
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: CommentFont};
    CGSize textSize         = [self.comment boundingRectWithSize:CGSizeMake(size.width, 0)
                                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                      attributes:attribute
                                                         context:nil].size;
    return textSize;
}
@end
