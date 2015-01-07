//
//  GameScene.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(void) didLoadFromCCB {
    self.userInteractionEnabled = true;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width/2;
    screenHeight = screenSize.height/2;
  
    dinosaur *dino = (dinosaur *) [CCBReader load:@"dinosaur"];
    dino.position = CGPointMake(screenWidth/2, screenHeight/2);
    
    [self addChild: dino];

}

@end
