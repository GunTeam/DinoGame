//
//  dinosaur.h
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface dinosaur : CCSprite {
    int ATTACK_THRESHOLD;
    int KNOCKBACK_THRESHOLD;
    int MAX_HEALTH; //maximum health
}

-(void) moveDinoForward;
-(void) moveDinoBackward;
-(Boolean) collidesWith:(dinosaur *)enemyDino;
-(void) attackDino:(dinosaur *)enemyDino;
-(Boolean) attackedByDino:(dinosaur *)enemyDino;
-(void) knockback;
-(void) die;

@property int health;
@property double speed;
@property int attack;
@property Boolean inAir;
@property Boolean readyToAttack;
@property int attackCounter;
@property int killBonus;
@property int afterAttackDelay; //how many frames the dino waits in between attacks
@property int price;

@end
