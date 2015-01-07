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
    
    strandsOfYarn = 0;
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
    numYarnsLabel = [CCLabelTTF labelWithString:@"8" fontName:@"Marker Felt" fontSize:24];
    numYarnsLabel.position = ccp((5./6)*screenWidth, (6./7)*screenHeight);
    [self addChild:numYarnsLabel z:1];
    self.chanceOfEnemySpawn = 5; //percentage of timesteps an enemy is spawned
    
    ourNest = (OurNest *) [CCBReader load:@"OurNest"];
    enemyNest = (EnemyNest *) [CCBReader load:@"EnemyNest"];
    ourNest.position = ccp(0, screenHeight/2);
    enemyNest.position = ccp(screenWidth, screenHeight/2);
    [self addChild:ourNest];
    [self addChild:enemyNest];
}

-(void)spawnEnemyDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = enemyNest.position;
    [enemyDinos addObject:newDino];
    [self addChild: newDino];

}

-(void)spawnOurDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = ourNest.position;
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
    
    strandsOfYarn = strandsOfYarn + 1;
    [numYarnsLabel setString:[NSString stringWithFormat:@"Num Yarns: %i", strandsOfYarn]];
    
    
    float randSpawnFlag = arc4random()%1000;
    if(randSpawnFlag < self.chanceOfEnemySpawn){
        [self spawnEnemyDino];
    }
}

@end
