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
#import "Raptor.h"
#import "Triceratops.h"
#import "Allosaurus.h"
#import "Pterodactyl.h"
#import "Nest.h"
#import "OurNest.h"
#import "EnemyNest.h"
#import "BallOfYarn.h"
#import "WTMGlyphDetector.h"
#import "WTMGlyphDetectorView.h"

@interface GameScene : CCNode {
    CGFloat screenWidth,screenHeight;
    CCPhysicsNode *physicsNode;
    NSMutableArray *ourDinos, *enemyDinos;
    OurNest *ourNest;
    EnemyNest *enemyNest;
    int strandsOfYarn;
    CCLabelTTF *_numYarnsLabel;
    BallOfYarn *ballOfYarn;
}

@property int chanceOfEnemySpawn;
@property (nonatomic, strong) WTMGlyphDetector *glyphDetector;
@property (nonatomic, strong) NSMutableArray *glyphNamesArray;
@property (nonatomic, strong) WTMGlyphDetectorView *gestureDetectorView;

@end
