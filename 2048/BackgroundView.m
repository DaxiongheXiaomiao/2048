//
//  BackgroundView.m
//  2048
//
//  Created by mac on 14-7-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define CORNER_FONT_STANDARD_HEIGHT 250.0
#define CORNER_RADIUS 12.0

//拉伸因素，当前view的高度/250
- (CGFloat)cornerScaleFactor {return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;}
//圆角矩形的圆角半径 12 * CORNER_FONT_STANDARD_HEIGHT
- (CGFloat)cornerRadius {return CORNER_RADIUS * [self cornerScaleFactor];}

- (CGFloat)cornerScaleFactorForElement:(CGFloat)height{return height / CORNER_FONT_STANDARD_HEIGHT;}

- (CGFloat)cornerRadiusForElement:(CGFloat)heightForElement{return CORNER_RADIUS * [self cornerScaleFactorForElement:heightForElement];}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

#define ORIGINAL_X 10
#define ORIGINAL_Y 10
#define ORIGINAL_WIDTH 60
#define ORIGINAL_HEIGHT 60
#define ORIGINAL_INTERVAL 70
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self drawBackground];
    //original point
     CGPoint point = CGPointMake(ORIGINAL_X, ORIGINAL_Y);
    //绘制背景
    for(int row=0;row<4;row++){
        for(int line=0;line<4;line++){
            [self drawElementWithPosition:point width:ORIGINAL_WIDTH height:ORIGINAL_HEIGHT];
            point.x += ORIGINAL_INTERVAL;
        }
        point.x = ORIGINAL_X;
        point.y += ORIGINAL_INTERVAL;
    }
    
}

//绘制背景
- (void)drawBackground{

    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    //在区域内绘制
    [roundedRect addClip];
    
    //use custom color
    UIColor *barkgroundColor = [UIColor colorWithRed:145 / 255.0
                                               green:145 / 255.0
                                                blue:145 / 255.0
                                               alpha:1.0];
    //选择画笔
    [barkgroundColor setFill];
    //用画笔绘制圆角矩形
    UIRectFill(self.bounds);
    
    //选择画笔
    [barkgroundColor setStroke];
    //绘制边框
    [roundedRect setLineWidth:2.0];
    [roundedRect stroke];
    
}

//绘制元素阴影
- (void)drawElementWithPosition:(CGPoint)point width:(CGFloat)width height:(CGFloat)height{
    CGRect elementRect = CGRectMake(point.x, point.y, width, height);
    UIBezierPath *elementBackgroundRect = [UIBezierPath bezierPathWithRoundedRect:elementRect
                                                                     cornerRadius:[self cornerRadiusForElement:elementRect.size.height]];
    //use custom color
    UIColor *elementBackgourndColor = [UIColor colorWithRed:176 / 255.0
                                                      green:176 / 255.0
                                                       blue:176 / 255.0
                                                      alpha:1.0];
    
    //选择画笔
    [elementBackgourndColor setFill];
    //用画笔绘制圆角矩形
    UIRectFill(elementRect);
    
    
    [elementBackgroundRect stroke];

}


@end
