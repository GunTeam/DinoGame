//
//  GameScene.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "GameScene.h"

dinosaur *dino;

@implementation GameScene

-(void) didLoadFromCCB {
    self.userInteractionEnabled = true;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width/2;
    screenHeight = screenSize.height/2;
  
    dino = (dinosaur *) [CCBReader load:@"dinosaur"];
    dino.position = CGPointMake(screenWidth/2, screenHeight/2);
    
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
}

-(void)spawnEnemyDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = CGPointMake(screenWidth/2, screenHeight/2);
    [enemyDinos addObject:newDino];
}

-(void)spawnOurDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = CGPointMake(screenWidth/2, screenHeight/2);
    [ourDinos addObject:newDino];
    [self addChild: newDino];
}

- (void)update:(CCTime)delta
{
    //move our dinosaurs forward
    for(dinosaur *thisDino in ourDinos){
        [thisDino moveDinoForward];
    }
    
    //move the enemy dinosaurs backward
    for(dinosaur *thisDino in enemyDinos){
        [thisDino moveDinoBackward];
    }
}
@end
