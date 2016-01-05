//
//  LayoutView.h
//  CommentLaout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSXComment.h"
 
@interface LayoutView : UIView
- (instancetype)initWithFrame:(CGRect)frame model:(NSXComment *)info parentView:(UIView*)p isLast:(BOOL)isLast;
@end
