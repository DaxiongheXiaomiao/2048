//
//  ElementLabel.h
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElementLabel : UILabel{
@public
    NSUInteger elementNumber;
    NSUInteger elementCurrentLocation;
    NSUInteger elementNextLocation;
    BOOL elementIsMerged;
}

// Designate initializer
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

- (void)drawElementWithNumber:(NSString *)numberInString;

@end
