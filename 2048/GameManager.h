//
//  GameManager.h
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

/*
    Main logic
       In this file, I take a Two-dimensional Array known is a Matrix as my model,
    then I put my element objects into the matrix to simulate the whole process.
 
       One thing I think you shuold know is that I only use _gameMatrix[1][1] to _gameMatrix[4][4]
    to make it easier transform the real location 11-44 into position in _gameMatrix
 
*/

/*
    Uses public instance variable to keep track the matrix
 */
@interface GameManager : NSObject{
    @public
        NSMutableArray *_gameMatrix;
        NSMutableArray *_currentAvailableMatrix;

}

@property (nonatomic) NSInteger score;
@property (nonatomic) NSString *record;

// Designated initializer
- (instancetype)initWithRandomElement;

// In order to get the relative object in the Matrix accroding to the given location
- (Element *)chooseElementAtLocation:(NSUInteger)location;

// Keep track of _currentAvailableMatrix to make sure new element is created in the right place
- (void)UpdateAvilableMatrix;

// If any changes happened in _gameMatrix, then game is not over
- (BOOL)isGameOver;

// Adjust _gameMatrix accroding to the corresponding movement
- (BOOL)matrixLeftToRight;
- (BOOL)matrixRightToLeft;
- (BOOL)matrixTopToBottom;
- (BOOL)matrixBottomToTop;

- (BOOL)saveRecord;
- (Element *)randomElemet;
- (void)addElementIntoGameMatrix:(NSMutableArray *)gameMatirx withElement:(Element *)randomElement;




@end
