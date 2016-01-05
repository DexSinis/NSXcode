//
//  LayoutView.m
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiao haibo. All rights reserved.
//

#import "LayoutView.h"
#import "LayoutContainerView.h"
#import "Constant.h"
//#import <UIViewController+KeyboardAdditions.h>
@interface LayoutView()

@property (nonatomic,strong) NSXComment *model;
@property (nonatomic,strong) UILabel      *nameLabel;
@property (nonatomic,strong) UILabel      *floorLabel;
@property (nonatomic,strong) UILabel      *commentLabel;
@property (nonatomic,strong) UILabel      *addressLabel;
@property (nonatomic,assign) UIView       *parent;
@property (nonatomic,assign) BOOL         isLastFloor;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatInputBottomSpace;

@end

@implementation LayoutView

- (instancetype)initWithFrame:(CGRect)frame model:(NSXComment *)amodel parentView:(UIView*)p isLast:(BOOL)isLast
{
    if (self = [super initWithFrame:frame]) {
        self.isLastFloor = isLast;
        self.parent = p;
        self.model = amodel;
        if (!self.isLastFloor) {
            self.layer.borderWidth = LayoutBordWidth;
            self.layer.borderColor = LayoutBordColor.CGColor;
            self.backgroundColor = LayoutBackgroundColor;
        }
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.text = self.model.username;
        _nameLabel.font = NameFont;
        _nameLabel.textColor = NameColor;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _addressLabel.textColor =[UIColor grayColor];
        _addressLabel.text = self.model.address;
        _addressLabel.font = AddressFont;
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.numberOfLines =0;
        _commentLabel.font = CommentFont;
        _commentLabel.text = self.model.comment;
        
       
        _floorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _floorLabel.font = AddressFont;
        _floorLabel.text = self.model.floor;
        _floorLabel.textColor =[UIColor grayColor];
        
        _nameLabel.frame = CGRectMake(5, self.parent.frame.size.height ,self.frame.size.width - 10, 34);
        _addressLabel.frame = CGRectMake(_nameLabel.frame.origin.x, self.parent.frame.size.height + 20 ,self.frame.size.width - 10, 34);
        _floorLabel.frame = CGRectMake(self.frame.size.width - 15, self.parent.frame.size.height +5 ,15, 34);
        _commentLabel.frame =  CGRectMake(5, self.parent.frame.size.height+40 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
       

        [self addSubview:_nameLabel];
        [self addSubview:_addressLabel];
        [self addSubview:_commentLabel];
        [self addSubview:_floorLabel];
        
        if (self.isLastFloor) {
            _nameLabel.hidden = YES;
            _addressLabel.hidden = YES;
            _floorLabel.hidden = YES;
            _commentLabel.frame = CGRectMake(5, self.parent.frame.size.height+5 ,self.frame.size.width - 10,self.frame.size.height - self.parent.frame.size.height - 40);
        }
        
    }
    
//    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
    
     UITapGestureRecognizer *longPressed = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    
//    longPressed.minimumPressDuration = 1;
    
    [self addGestureRecognizer:longPressed];
    
    return self;
}


-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture


{
    
//    if (gesture.state==UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        

                CGPoint location = [gesture locationInView:self];
                NSLog(@"%@",NSStringFromCGPoint(location));
        UIMenuController *menu=[UIMenuController sharedMenuController];
        NSLog(@"UILongPressGestureRecognizer---------->");
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"评论" action:@selector(copyItemClicked:)];
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
        UIMenuItem *likeItem = [[UIMenuItem alloc] initWithTitle:@"赞" action:@selector(likeItemClicked:)];

        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,likeItem,nil]];
        //        [menu setTargetRect:CGRectMake(location.x, location.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) inView:self.view];
        //        UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(location.x, location.y,1 , 1)];
        //        [menu setTargetRect:CGRectMake(location.x,location.y,0,0) inView:self.view];
        [menu setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:self];
        NSLog(@"%@",NSStringFromCGRect(self.bounds));
        NSLog(@"%@",NSStringFromCGRect(self.frame));
        
        [menu setMenuVisible:YES animated:YES];
//    }
    
    
    
}

#pragma mark 处理action事件
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action ==@selector(copyItemClicked:)){
        return YES;
    }else if (action==@selector(resendItemClicked:)){
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}
#pragma mark  实现成为第一响应者方法
-(BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark method

-(void)copyItemClicked:(id)sender{
    NSLog(@"评论");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commentNotification" object:nil userInfo:@{@"comment":self.commentLabel.text}];
    // 通知代理
}

-(void)resendItemClicked:(id)sender{
    NSLog(@"转发");
    NSLog(@"%@",self.commentLabel.text);
    //通知代理
}

-(void)likeItemClicked:(id)sender{
    NSLog(@"转发");
    NSLog(@"%@",self.commentLabel.text);
    //通知代理
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
