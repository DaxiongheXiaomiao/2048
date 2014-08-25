//
//  Element.m
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import "Element.h"

@implementation Element


- (instancetype)initWithNumber:(NSInteger)number atLocation:(NSInteger)currentLocation {


    self = [super init];
    
    if(self){
        
        self.number = number;
        self.currentLocation = currentLocation;
        self.nextLocation = currentLocation;
        self.isMerged = NO;
    
    }
    
    
    return self;
}
@end
