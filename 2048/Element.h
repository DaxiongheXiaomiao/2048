//
//  Element.h
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Element : NSObject

/* property number for record the current number of this element
 * 
 * property isMerge is set to YES only under the condition that
 * two elements have been add to one, Such as 2 2 0 0 -> 0 0 0 4
 *
 */
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger currentLocation;
@property (nonatomic) NSUInteger nextLocation;
@property (nonatomic) BOOL isMerged;


- (instancetype)initWithNumber:(NSInteger)number atLocation:(NSInteger)currentLocation;

@end
