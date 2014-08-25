 //
//  ZJWViewController.m
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import "ZJWViewController.h"
#import "BackgroundView.h"
#import "ElementLabel.h"
#import "GameManager.h"
#import "Element.h"

@interface ZJWViewController () <NSCoding>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet BackgroundView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UILabel *currentScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;

@property (strong,nonatomic) GameManager *gameManager;
@property (nonatomic) NSInteger direction;
@end

@implementation ZJWViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.titleLabel.layer.cornerRadius = 10.0;
    self.restartButton.layer.cornerRadius = 8.0;
    self.currentScoreLabel.layer.cornerRadius = 8.0;
    self.recordLabel.layer.cornerRadius = 8.0;
    
    [self gameStart];
    
    __weak ZJWViewController *weakSelf = self;
    
    self.archiveRecord = ^{
        
        [weakSelf.gameManager saveRecord];
    };
    
}

- (void)viewWillDisappear:(BOOL)animated{


}
#pragma mark - GameStart

- (void)gameStart{

    self.gameManager = [[GameManager alloc] initWithRandomElement];
    for(id objArray in self.gameManager->_gameMatrix){
        for(id obj in objArray){
            if([obj isKindOfClass:[Element class]]){
                Element *element = (Element *)obj;
                if(element.number != 0){
                    [self addLabelwithNumber:[NSString stringWithFormat:@"%lu",(unsigned long)element.number]
                             currentLocation:element.currentLocation
                                nextLocation:element.nextLocation];
                }
                
            }
            
        }
    }
    
    self.currentScoreLabel.text = @"分数 \n 0";
    if ([self.gameManager.record isEqualToString:@"0"]) {
        self.recordLabel.text = @"历史最高记录 \n 0";
    }else{
        self.recordLabel.text = [NSString stringWithFormat:@"历史最高记录 \n %@",self.gameManager.record];
    }
    

}


#pragma mark - Action

#define directionLeftToRight 1
#define directionRightToLeft 2
#define directionTopToBottom 3
#define directionBottomToTop 4


- (IBAction)swipeFromLeftToRight:(UISwipeGestureRecognizer *)sender {
    
    self.direction = directionLeftToRight;
    [self updateUI];
    
}
- (IBAction)swipeFromRightToLeft:(UISwipeGestureRecognizer *)sender {
    
    self.direction = directionRightToLeft;
    [self updateUI];
}

- (IBAction)swipeFromTopToBottom:(UISwipeGestureRecognizer *)sender {
    
    self.direction = directionTopToBottom;
    [self updateUI];
}
- (IBAction)swipeFromBottomToTop:(UISwipeGestureRecognizer *)sender {
    
    self.direction = directionBottomToTop;
    [self updateUI];
}

- (IBAction)reset:(UIButton *)sender {
    
    for(id obj in [self.backgroundView subviews]){
        if([obj isKindOfClass:[ElementLabel class]]){
            
            ElementLabel *label = (ElementLabel *)obj;
            [label removeFromSuperview];
        }
    }
    
    self.gameManager = nil;
    [self gameStart];
    
}

#pragma mark - Update

- (void)updateUI{
    
    
    switch (self.direction) {
        case directionLeftToRight:{
            
            if([self.gameManager matrixLeftToRight]){
                
                [self doAnimation];
                [self addRandomElementLabel];
            }
        }
            break;
        case directionRightToLeft:{
        
            if([self.gameManager matrixRightToLeft]){
            
                [self doAnimation];
                [self addRandomElementLabel];
            }
        }
            break;
        case directionTopToBottom:{
        
            if([self.gameManager matrixTopToBottom]){
            
                [self doAnimation];
                [self addRandomElementLabel];
            }
        }
            break;
            
        case directionBottomToTop:{
        
            if([self.gameManager matrixBottomToTop]){
            
                [self doAnimation];
                [self addRandomElementLabel];
            }
        }
            break;
    }
    
    self.currentScoreLabel.text = [NSString stringWithFormat:@"分数 \n %ld",(long)self.gameManager.score];
    if([self isCurrentScoreHigherThanRecord:self.gameManager.record currentScore:self.gameManager.score]){
    
        self.recordLabel.text = [NSString stringWithFormat:@"历史最高记录 \n %ld",(long)self.gameManager.score];
    }else{
    
        self.recordLabel.text = [NSString stringWithFormat:@"历史最高记录 \n %@",self.gameManager.record];
    }
    
    if([self.gameManager isGameOver]){
        
        [self.gameManager saveRecord];

    }
}

- (BOOL)isCurrentScoreHigherThanRecord:(NSString *)record currentScore:(NSInteger)currentScore{
    
    BOOL flag = false;
    int recordInInt = [record intValue];
    if(currentScore >= recordInInt){
    
        flag = true;
    }
    
    return  flag;
}

//进行转换
- (void)doAnimation{
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for(id obj in [self.backgroundView subviews]){
                             if([obj isKindOfClass:[ElementLabel class]]){
                                 // Get the relative label
                                 ElementLabel *relativeElementLabel = (ElementLabel *)obj;
                                 
                                 // Get the corresponding element in matrix
                                 Element *oldElement = [self.gameManager chooseElementAtLocation:relativeElementLabel->elementCurrentLocation];
                                 
                                 // Get the element of the next locaion it should be
                                 Element *newElement = [self.gameManager chooseElementAtLocation:oldElement.nextLocation];
                                 
                                 // Change the properties of relativeElementLabel into right one
                                 relativeElementLabel->elementCurrentLocation = newElement.currentLocation;
                                 relativeElementLabel->elementNextLocation = newElement.nextLocation;// currentLocation
                                 relativeElementLabel->elementNumber = newElement.number;
                                 relativeElementLabel->elementIsMerged = newElement.isMerged;
                                 
                                 
                                 // In order make sure it sync
                                 oldElement.nextLocation = oldElement.currentLocation;
                                 
                                 // Set the defalut isMerged value
                                 newElement.isMerged = NO;
                                 
                                 // Transport location so that we can use it to get the label into right position
                                 CGPoint realpoint = [self transportIntegerLocationIntoCGPointLocation:relativeElementLabel->elementCurrentLocation];
                                 // While current number is not zero, redraw the elementLabel
                                 // Because only under this kind of situation, a combination happened,
                                 // so we have to update the view
                                 if(relativeElementLabel->elementNumber != 0){
                                     
                                     // Set new number for relativeElementLabel
                                     [relativeElementLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)relativeElementLabel->elementNumber]];
                                     // Redraw relativeElementLabel
                                     [relativeElementLabel drawElementWithNumber:[NSString stringWithFormat:@"%lu",(unsigned long)relativeElementLabel->elementNumber]];
                                 }
                                 
                                 // Unlike the text of label, we have to update the position of
                                 // relativeElementLabel under any condition as long as we update the Matrix
                                 // If the relativeElementLabel is been merged, make it "Pop Out"
                                 if(relativeElementLabel->elementIsMerged){
                                     [relativeElementLabel setFrame:CGRectMake(realpoint.x - 5,
                                                                               realpoint.y - 5,
                                                                               70, 70)];
                                 }else{
                                 
                                     [relativeElementLabel setFrame:CGRectMake(realpoint.x,
                                                                               realpoint.y,
                                                                               60, 60)];
                                 }
                                 if(relativeElementLabel->elementNumber == 0){
                                     [relativeElementLabel setAlpha:0.0];
                                 }
                                 
                             }
                             
                         }
                     } completion:^(BOOL finished) {
                         
                         // Remove the "Zero ElementLable"
                         if(finished){
                             for(id obj in [self.backgroundView subviews]){
                                 if([obj isKindOfClass:[ElementLabel class]]){
                                     ElementLabel *label = (ElementLabel *)obj;
                                     if(label->elementNumber == 0){
                                         [label removeFromSuperview];
                                     }

                                     if(label->elementIsMerged){
                                     
                                         //label->elementOldNumber = label->elementNumber;
                                         [UIView animateWithDuration:0.05
                                                          animations:^{
                                                              CGPoint realpoint = [self transportIntegerLocationIntoCGPointLocation:label->elementCurrentLocation];
                                                              [label setFrame:CGRectMake(realpoint.x,realpoint.y,60, 60)];
                                                              
                                                          }];
                                     }
                                 }
                                 
                             }
                         }
                     }];
}


// Create random Element label
- (void)addRandomElementLabel{
    
    [self.gameManager UpdateAvilableMatrix];
    
    Element *element = [self.gameManager randomElemet];
    [self.gameManager addElementIntoGameMatrix:self.gameManager->_gameMatrix withElement:element];
    [self addLabelwithNumber:[NSString stringWithFormat:@"%lu",(unsigned long)element.number]
             currentLocation:element.currentLocation
                nextLocation:element.nextLocation];

}


- (void)addLabelwithNumber:(NSString *)number
           currentLocation:(NSUInteger)currentLocation
              nextLocation:(NSUInteger)nextLocation{
    
    CGPoint basedPoint = [self transportIntegerLocationIntoCGPointLocation:currentLocation];
    ElementLabel *label = [[ElementLabel alloc] initWithFrame:CGRectMake(basedPoint.x + 30, basedPoint.y + 30, 0, 0) text:number];
    label->elementCurrentLocation = currentLocation;
    label->elementNextLocation = nextLocation;
    label->elementNumber =  [number intValue];
    label->elementIsMerged = NO;
    
    [self.backgroundView addSubview:label];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [label setFrame:CGRectMake(basedPoint.x,basedPoint.y,60,60)];
                     }];
    
}


- (CGPoint)transportIntegerLocationIntoCGPointLocation:(NSUInteger)integerLocation{


    CGPoint point;
    
    NSUInteger increase;
    if(integerLocation < 21){
        increase = integerLocation - 11;
        point = CGPointMake(10 + increase * 70, 10);
    }else if(integerLocation < 31){
        increase = integerLocation - 21;
        point = CGPointMake(10 + increase * 70, 80);
    }else if(integerLocation < 41){
        increase = integerLocation - 31;
        point = CGPointMake(10 + increase * 70, 150);
    }else if(integerLocation < 51){
        increase = integerLocation - 41;
        point = CGPointMake(10 + increase * 70, 220);
    }
    
    return point;

}









@end








