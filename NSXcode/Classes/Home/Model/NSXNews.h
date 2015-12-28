//
//  OSCNews.h
//  iosapp
//
//  Created by chenhaoxiang on 10/27/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

//#import "OSCBaseObject.h"
#import "MJExtension.h"
typedef NS_ENUM(NSUInteger, NewsType)
{
    NewsTypeStandardNews,
    NewsTypeSoftWare,
    NewsTypeQA,
    NewsTypeBlog
};

@interface NSXNews : NSObject

@property (nonatomic, copy) NSString *newsId; //
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *body;
@property (nonatomic, assign) int commentCount;
@property (nonatomic, copy)   NSString *author;
@property (nonatomic, assign) int64_t authorID;
@property (nonatomic, assign) NewsType type; //
@property (nonatomic, strong) NSDate *pubDate;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *eventURL;
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, assign) int64_t authorUID2;


//@property(copy,nonatomic)NSString *title;   //日报标题
//@property(copy,nonatomic)NSNumber *storyID; //日报id
@property(strong,nonatomic)NSArray *images; //图片url数组
@property(assign,nonatomic)BOOL isMultipic; //是否多图
//@property(strong,nonatomic)NSNumber *type;  //日报类型
@property(copy,nonatomic)NSString *image;   //图片



@property (nonatomic, strong) NSMutableAttributedString *attributedTittle;
@property (nonatomic, strong) NSAttributedString *attributedCommentCount;

@end
