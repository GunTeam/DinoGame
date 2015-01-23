//
//  GameScene.h
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "dinosaur.h"
#import "TRex.h"
#import "Stegosaurus.h"
#import "Triceratops.h"
#import "Allosaurus.h"
#import "Pterodactyl.h"
#import "Nest.h"
#import "OurNest.h"
#import "EnemyNest.h"
#import "BallOfYarn.h"
#import "TreePot.h"
#import "MainScene.h"

@interface GameScene : CCNode <CCPhysicsCollisionDelegate>{
    CGFloat screenWidth,screenHeight;
    CCPhysicsNode *_physicsNode;
    NSMutableArray *ourDinos, *enemyDinos;
    OurNest *ourNest;
    EnemyNest *enemyNest;
    int strandsOfYarn;
    CCLabelTTF *_numYarnsLabel;
    CCButton *_yarnBallLabel;
    CCLabelTTF *_stegoPrice, *_tricePrice, *_allosaurusPrice, *_trexPrice, *_pterodactylPrice;
}

@property int chanceOfEnemySpawn;
@property float level;

@end
