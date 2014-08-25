//
//  GameManager.m
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//



#import "GameManager.h"
#import "Element.h"

@interface GameManager()<NSCoding>

@end

@implementation GameManager

#pragma mark - initialization

// Lazy initialize the _gameMatrix so that we have a model
- (NSMutableArray *)gameMatrix{

    if(!_gameMatrix){
        
        _gameMatrix = [[NSMutableArray alloc] initWithObjects:
                       [NSMutableArray arrayWithObjects:@0, nil],
                       [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0, nil],
                       [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0, nil],
                       [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0, nil],
                       [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0, nil],
                       nil];

        
        for(int row=0;row<5;row++){
            if(row != 0){
                for(int line=0;line<5;line++){
                    if(line != 0){
                        
                        Element *element = [[Element alloc] initWithNumber:0 atLocation:(row * 10 + line)];
                        [[_gameMatrix objectAtIndex:row] replaceObjectAtIndex:line withObject:element];
                    }
                }
            }
        }
        self.score = 0;
        NSString *path = [self recordPath];
        self.record = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        NSLog(@"%@",self.record);
        if(!self.record){

            NSLog(@"NO record!");
            self.record = @"0";
        }
        
    }
    return _gameMatrix;
}

// Use there number to represent which location is available
- (NSMutableArray *)currentAvailableMatrix{
    
    if(!_currentAvailableMatrix){
    
    
        _currentAvailableMatrix = [NSMutableArray arrayWithObjects:@"11",@"12",@"13",@"14",
                                                                   @"21",@"22",@"23",@"24",
                                                                   @"31",@"32",@"33",@"34",
                                                                   @"41",@"42",@"43",@"44",nil];
    }
    
    return _currentAvailableMatrix;
}

- (instancetype)initWithRandomElement{

    self = [super init];
    
    if(self){
        
        [self currentAvailableMatrix];
        [self addElementIntoGameMatrix:[self gameMatrix] withElement:[self randomElemet]];
        [self addElementIntoGameMatrix:[self gameMatrix] withElement:[self randomElemet]];
    }
    
    
    return self;
}


#pragma mark - AddElement

// Add random element into _gameMatrix to continue the game
- (void)addElementIntoGameMatrix:(NSMutableArray *)gameMatirx withElement:(Element *)randomElement{
    
    int row = (int)(randomElement.currentLocation / 10);
    int line = (int)(randomElement.currentLocation % 10);
    
    [[gameMatirx objectAtIndex:row] replaceObjectAtIndex:line withObject:randomElement];
}

// Draw a random element, my solution here is not very good
- (Element *)randomElemet{
    
    // Create a random number between 0-9
    int randomNumberRange = arc4random() % 10;
    int randomNumber;
    
    // 70% to get a new 2, and 30% to get a new 4
    if(randomNumberRange < 7){
        randomNumber = 2;
    }else{
        randomNumber = 4;
    }
    
    // Create a random element in one of the available positions
    int randomLocation;
    int randomLocationIndex = arc4random()%[_currentAvailableMatrix count];
    
    if([[_currentAvailableMatrix objectAtIndex:randomLocationIndex] isKindOfClass:[NSString class]]){
    
        NSString *elementLocationInString = (NSString *)[_currentAvailableMatrix objectAtIndex:randomLocationIndex];
        randomLocation = [elementLocationInString intValue];
        
        // You have to remove this position from the
        // _currentAvailableMatrix once it already has a element on it
        [_currentAvailableMatrix removeObjectAtIndex:randomLocationIndex];
    
    }
    
    return [[Element alloc] initWithNumber:randomNumber atLocation:randomLocation];

}




#pragma mark - Deal With Matrix
/*
    To Simulate the swipe
        Only need to implement swipe from left to right, and right to left,
    to achieve top to bottom adn bottom to top, you just need to transport
    the _gameMatrix and simulate the process
*/

- (void)matrixTransport{

    Element *temp;
    for(int row=1;row<=4;row++){
        for (int line=row; line<=4; line++) {
            temp = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:line];
            [[_gameMatrix objectAtIndex:row] replaceObjectAtIndex:line withObject:
             [[_gameMatrix objectAtIndex:line] objectAtIndex:row]];
            [[_gameMatrix objectAtIndex:line] replaceObjectAtIndex:row withObject:temp];
        }
    }


}

// When you transform the matrix, you have to transform the loction too.
- (void)transportNextLocation{

    Element *element;
    for(int row=1;row<=4;row++){
        for(int line=1;line<=4;line++){
            element =(Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:line];
            if( element.nextLocation != 0){
            
                element.nextLocation = (element.nextLocation % 10) * 10 + (element.nextLocation / 10);
            }
        }
    }

}

- (void)transportCurrentLocation{
    Element *element;
    for(int row=1;row<=4;row++){
        for(int line=1;line<=4;line++){
            element =(Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:line];
            element.currentLocation = (element.currentLocation % 10) * 10 + (element.currentLocation / 10);
            element.nextLocation = (element.nextLocation % 10) * 10 + (element.nextLocation / 10);
        }
    }

}

// Get the corresponding element in _gameMatrix accroding the given location
// ex:  location 23 means _gameMatrix[2][3]
- (Element *)chooseElementAtLocation:(NSUInteger)location{
    
    Element *element;
    int row = (int)(location / 10);
    int line =(int)(location % 10);
    
    element = [[_gameMatrix objectAtIndex:row] objectAtIndex:line];
    
    return element;
    
}

// You have to update _currentAvailableMatrix evey time
// after you have changed the _gameMatrix to keep sync

- (void)UpdateAvilableMatrix{
    
    for(int row=1;row<=4;row++){
        for(int line=1;line<=4;line++){
            
            Element *element = [[_gameMatrix objectAtIndex:row] objectAtIndex:line];
            NSString *locationInString = [NSString stringWithFormat:@"%lu",(unsigned long)element.currentLocation];
            if(element.number != 0){
                if([_currentAvailableMatrix containsObject:locationInString]){
                    [_currentAvailableMatrix removeObject:locationInString];
                }
            }else{
                if (![_currentAvailableMatrix containsObject:locationInString]) {
                    [_currentAvailableMatrix addObject:locationInString];
                }
            }
            
        }
    }
}




#pragma mark - DealWithElement

// Get ready when you need to move matrix from top to bottom or
// from bottom to top
- (void)prepareForMatrixTransport{
    
    //矩阵转置
    [self matrixTransport];
    //模拟从右向左的过程
    [self transportCurrentLocation];
    
}

- (BOOL)matrixTopToBottom{


    [self prepareForMatrixTransport];
    
    BOOL flagforMatrixHasChanged = [self matrixLeftToRight];
    
    [self endForMatrixTransport];
    
    return flagforMatrixHasChanged;

    
}

- (BOOL)matrixBottomToTop{
    
    [self prepareForMatrixTransport];
    
    BOOL flagforMatrixHasChanged = [self matrixRightToLeft];
    
    [self endForMatrixTransport];
    
    return flagforMatrixHasChanged;

}



// After the matrix has been transport, you have to restore the matrix
- (void)endForMatrixTransport{
    
    [self transportCurrentLocation];
    [self matrixTransport];
}

/*
 * The process of dealing the matrix can be devided into 2 part:
 *      1. Iterate every line of matrix, if the number of adjoining elements equals, then add them together
 *      2. Move all the elements to the "Bottom"(The direction you let your finger leave).
 *
*/
- (BOOL)matrixLeftToRight{
    
    BOOL flagforMatrixHasChanged = false;
    Element *currentElement;
    Element *frontElement;
    for(NSInteger row=1;row<=4;row++){
        for(NSInteger line=4;line>=1;line--){
        
            currentElement =(Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:line];

            if(currentElement.number != 0){

                NSInteger index = line - 1;
                while (index >= 1) {
                    
                    frontElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:index];
                    if(currentElement.number == frontElement.number){
                        
                        flagforMatrixHasChanged = true;
                        currentElement.number *= 2;
                        [self manageWithScore:currentElement.number];
                        currentElement.isMerged = YES;
                        frontElement.number = 0;
 
                        frontElement.nextLocation = row * 10 + line - 1;
                        break;
            
                    }else if(frontElement.number != 0){
                    
                        break;
                    }
                    index--;
                }
            
            }

            if(line == 1){

                for(NSInteger latterElementIndex=4;latterElementIndex>=1;latterElementIndex--){
                    currentElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:latterElementIndex];
                    if(currentElement.number == 0){
                    
                        NSInteger frontElementIndex = latterElementIndex - 1;
                        while(frontElementIndex >= 1){
                            
                            frontElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:frontElementIndex];
                            if(frontElement.number != 0){
                            
                                flagforMatrixHasChanged = true;
                                currentElement.number = frontElement.number;
                                frontElement.number = 0;

                                frontElement.nextLocation = currentElement.currentLocation;
                                break;
                            }
                            frontElementIndex -- ;
                        }
                    }
                
                }
            
            }
        
        }
    }
    
    return flagforMatrixHasChanged;
}


- (BOOL)matrixRightToLeft{

    BOOL flagforMatrixHasChanged = false;
    Element *currentElement;
    Element *latterElement;
    for(NSInteger row=1;row<=4;row++){
        for(NSInteger line=1;line<=4;line++){
            
            currentElement =(Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:line];

            if(currentElement.number != 0){

                NSInteger index = line + 1;
                while (index <= 4) {
                    
                    latterElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:index];
                    if(currentElement.number == latterElement.number){
                        
                        flagforMatrixHasChanged = true;
                        currentElement.number *= 2;
                        [self manageWithScore:currentElement.number];
                        currentElement.isMerged = YES;
                        latterElement.number = 0;

                        latterElement.nextLocation = row * 10 + line + 1;
                        break;
                    }else if( latterElement.number != 0){
                        
                        break;
                    }
                    index++;
                }
                
            }

            if(line == 4){

                for(NSInteger frontElementIndex=1;frontElementIndex<=4;frontElementIndex++){
                    currentElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:frontElementIndex];
                    if(currentElement.number == 0){
                        
                        NSInteger latterElementIndex = frontElementIndex + 1;
                        while(latterElementIndex <= 4){
                            
                            latterElement = (Element *)[[_gameMatrix objectAtIndex:row] objectAtIndex:latterElementIndex];
                            if(latterElement.number != 0){
                                
                                flagforMatrixHasChanged = true;
                                currentElement.number = latterElement.number;
                                latterElement.number = 0;

                                latterElement.nextLocation = currentElement.currentLocation;
                                break;
                            }
                            latterElementIndex ++ ;
                        }
                    }
                    
                }
                
            }
            
        }
    }
    
    return flagforMatrixHasChanged;
}

- (BOOL)isGameOver{

    BOOL flagForIsGameOver = true;
    Element *frontElement;
    Element *latterElement;
    Element *upElement;
    Element *downElement;
    
    for(int row=1;row<=4;row++){
        for(int line=1;line<=4;line++){

            frontElement = [[_gameMatrix objectAtIndex:row] objectAtIndex:line];
            if(frontElement.number == 0){
                
                flagForIsGameOver = false;
                break;
            }
            if(line<=3){
                latterElement = [[_gameMatrix objectAtIndex:row] objectAtIndex:(line + 1)];
                if(frontElement.number == latterElement.number){
                    flagForIsGameOver = false;
                    break;
                }
            }
            

            upElement = [[_gameMatrix objectAtIndex:line] objectAtIndex:row];
            if(upElement.number == 0){
            
                flagForIsGameOver = false;
                break;
            }
            if(row<=3){
                downElement = [[_gameMatrix objectAtIndex:line] objectAtIndex:(row + 1)];
                if(upElement.number == downElement.number){
                
                    flagForIsGameOver = false;
                    break;
                }
            }
        }
        if(!flagForIsGameOver){
        
            break;
        }
    }
    
    
    return  flagForIsGameOver;

}

#pragma mark - Score

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

- (void)manageWithScore:(NSInteger)number{

    switch (number) {
        case number_4:
            self.score += 4;
            break;
        case number_8:
            self.score += 8;
            break;
        case number_16:
            self.score += 16;
            break;
        case number_32:
            self.score += 32;
            break;
        case number_64:
            self.score += 64;
            break;
        case number_128:
            self.score += 128;
            break;
        case number_256:
            self.score += 256;
            break;
        case number_512:
            self.score += 512;
            break;
        case number_1024:
            self.score += 1024;
            break;
        case number_2048:
            self.score += 2048;
            break;
        case number_4096:
            self.score += 4096;
            break;
        case number_8192:
            self.score += 8192;
            break;
        case number_16384:
            self.score += 16384;
            break;
        default:
            break;
    }
    
    NSInteger record = [self.record integerValue];
    record = self.score > record ? self.score : record;
    
    self.record = [NSString stringWithFormat:@"%ld",(long)record];
    
}

#pragma mark - NSCoding Delegate

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.record forKey:@"record"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        _record = [aDecoder decodeObjectForKey:@"record"];
    }
    return self;
}

- (NSString *)recordPath{

    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);

    NSString *documentDirectory = [documentDirectories firstObject];

    return [documentDirectory stringByAppendingPathComponent:@"my2048record.archive"];

}

- (BOOL)saveRecord{

    NSString *path = [self recordPath];

    return [NSKeyedArchiver archiveRootObject:self.record toFile:path];

}

@end
