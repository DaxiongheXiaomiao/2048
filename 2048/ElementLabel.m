//
//  ElementLabel.m
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import "ElementLabel.h"

@implementation ElementLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text{

    self = [super initWithFrame:frame];
    
    if(self){
        [self drawElementWithNumber:text];
    }
    
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
static const int number_2 = 2;
static const int number_4 = 4;
static const int number_8 = 8;
static const int number_16 = 16;
static const int number_32 = 32;
static const int number_64 = 64;
static const int number_128 = 128;
static const int number_256 = 256;
static const int number_512 = 512;
static const int number_1024 = 1024;
static const int number_2048 = 2048;
static const int number_4096 = 4096;
static const int number_8192 = 8192;
static const int number_16384 = 16384;


- (void)drawElementWithNumber:(NSString *)numberInString{
    
    self.textAlignment = NSTextAlignmentCenter;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    
    // The option to center the content in the view’s bounds, keeping the proportions the same.
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.text = numberInString;
    
    int number = [numberInString intValue];
    
    
    self.textColor = [UIColor colorWithRed:255 / 255.0
                                     green:255 / 255.0
                                      blue:255 / 255.0
                                     alpha:1.0];
    
    switch (number) {
        case number_2:{
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:230 / 255.0
                                                   green:230 / 255.0
                                                    blue:230 / 255.0
                                                   alpha:1.0];
            
            self.textColor = [UIColor colorWithRed:69 / 255.0
                                             green:69 / 255.0
                                              blue:69 / 255.0
                                             alpha:1.0];
            
        }
            break;
        case number_4:{
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:250 / 255.0
                                                   green:245 / 255.0
                                                    blue:230 / 255.0
                                                   alpha:1.0];
            
            self.textColor = [UIColor colorWithRed:69 / 255.0
                                             green:69 / 255.0
                                              blue:69 / 255.0
                                             alpha:1.0];
        
        }
            break;
        case number_8:{
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:238 / 255.0
                                                   green:154 / 255.0
                                                    blue:73 / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_16:{
        
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:255 / 255.0
                                                   green:127 / 255.0
                                                    blue:80 / 255.0
                                                   alpha:1.0];
        }
            break;
            
        case number_32:{
            
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:246 / 255.0
                                                   green:132 / 255.0
                                                    blue:95 / 255.0
                                                   alpha:1.0];
        }
            break;
            
        case number_64:{
            
            self.font = [UIFont boldSystemFontOfSize:40];
            
            self.backgroundColor = [UIColor colorWithRed:246 / 255.0
                                                   green:94  / 255.0
                                                    blue:59  / 255.0
                                                   alpha:1.0];
        }
            break;
            
        case number_128:{
            
            self.font = [UIFont boldSystemFontOfSize:35];
            
            self.backgroundColor = [UIColor colorWithRed:232 / 255.0
                                                   green:232  / 255.0
                                                    blue:9  / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_256:{
            
            self.font = [UIFont boldSystemFontOfSize:35];
            
            self.backgroundColor = [UIColor colorWithRed:255 / 255.0
                                                   green:204 / 255.0
                                                    blue:0   / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_512:{
            
            self.font = [UIFont boldSystemFontOfSize:35];
            
            self.backgroundColor = [UIColor colorWithRed:205 / 255.0
                                                   green:205 / 255.0
                                                    blue:0   / 255.0
                                                   alpha:1.0];
        }
            break;
            
        case number_1024:{
            
            self.font = [UIFont boldSystemFontOfSize:25];
            
            self.backgroundColor = [UIColor colorWithRed:172 / 255.0
                                                   green:172 / 255.0
                                                    blue:0   / 255.0
                                                   alpha:1.0];
        }
            break;
          
        case number_2048:{
            
            self.font = [UIFont boldSystemFontOfSize:25];
            
            self.backgroundColor = [UIColor colorWithRed:237 / 255.0
                                                   green:194  / 255.0
                                                    blue:46  / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_4096:{
            
            self.font = [UIFont boldSystemFontOfSize:25];
            
            self.backgroundColor = [UIColor colorWithRed:173 / 255.0
                                                   green:183  / 255.0
                                                    blue:119  / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_8192:{
            
            self.font = [UIFont boldSystemFontOfSize:25];
            
            self.backgroundColor = [UIColor colorWithRed:170 / 255.0
                                                   green:183  / 255.0
                                                    blue:102  / 255.0
                                                   alpha:1.0];
        }
            break;
        case number_16384:{
            
            self.font = [UIFont boldSystemFontOfSize:21];
            
            self.backgroundColor = [UIColor colorWithRed:164 / 255.0
                                                   green:183  / 255.0
                                                    blue:79  / 255.0
                                                   alpha:1.0];
        }
            break;
            
        default:
            break;
    }
    
}






@end
