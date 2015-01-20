//
//  BallOfYarn.m
//  dinogame
//
//  Created by Laura Breiman on 1/18/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "BallOfYarn.h"


@implementation BallOfYarn

-(void) onEnter{
    self.userInteractionEnabled = TRUE;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    BallOfYarn *newBall = (BallOfYarn*)[CCBReader load:@"BallOfYarn"];
    [self.parent addChild:newBall];
    newBall.position = self.position;
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    // we want to know the location of our touch in this scene
    CGPoint touchLocation = [touch locationInNode:self.parent];
    CCLOG(@"%f", touchLocation.x);
    self.position = touchLocation;
}

-(void) touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self removeFromParent];
}

-(void) touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self removeFromParent];
}

@end
