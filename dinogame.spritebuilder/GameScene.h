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
#import "Nest.h"
#import "OurNest.h"
#import "EnemyNest.h"

@interface GameScene : CCNode {
    CGFloat screenWidth,screenHeight;
    CCPhysicsNode *physicsNode;
    NSMutableArray *ourDinos, *enemyDinos;
    OurNest *ourNest;
    EnemyNest *enemyNest;
    int strandsOfYarn;
    CCLabelTTF *numYarnsLabel;
}

@property int chanceOfEnemySpawn;

@end
