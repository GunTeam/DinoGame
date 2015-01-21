//
//  dinosaur.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "dinosaur.h"

@implementation dinosaur

@synthesize health, speed, attack, inAir, killBonus, readyToAttack, attackCounter, afterAttackDelay, price;

-(void) didLoadFromCCB{
    self.isEnemy = false;
    MAX_HEALTH = 100;
    self.health = MAX_HEALTH;
    KNOCKBACK_THRESHOLD = MAX_HEALTH/2; //point at which the dino gets knocked back
    _healthLabel.string = [NSString stringWithFormat:@"%d", self.health];
    self.attack = 10;
    self.speed = 0.01; //default
    ATTACK_THRESHOLD = 10; //number of pix between this dino and its attack target. e.g. some dinosaurs get closer than others to their enemy
    self.readyToAttack = true;
    self.afterAttackDelay = 60;
    self.attackCounter = 0;
    self.price = 200;
    self.killBonus = 10;
}

-(void) moveDinoForward{
    self.position = ccp( self.position.x + 100*self.speed, self.position.y );
//    CCLOG(@"%i", self.position.x);
}

-(void) moveDinoBackward{
    self.position = ccp( self.position.x - 100*self.speed, self.position.y );
}

-(Boolean) collidesWith:(dinosaur *)otherDino{
    int distanceAway = (1./2)*self.contentSize.width + (1./2)*otherDino.contentSize.width;
    if( abs(otherDino.position.x - self.position.x) <= (ATTACK_THRESHOLD+distanceAway)){
        return true;
    }
    return false;
}

-(void) attackDino:(dinosaur *)enemyDino{
    enemyDino.health -= self.attack;
}

-(void) knockback{
    int knockbackAmount = (0.3)*self.contentSize.width;
    if(self.isEnemy){ //we'll knock it backwards
        knockbackAmount *= -1;
    }
    
    CCActionMoveBy *mover = [CCActionMoveBy actionWithDuration:1 position:ccp(-knockbackAmount,0)];
    [self runAction:mover];
    [self.animationManager runAnimationsForSequenceNamed:@"Knockback"];
}

-(void) die{
    [self.animationManager runAnimationsForSequenceNamed:@"Dying"];
    CCActionMoveBy *mover = [CCActionMoveBy actionWithDuration:1 position:ccp(0,-(1./2)*self.contentSize.height)];
    [self runAction:mover];
    [self scheduleOnce:@selector(removeFromParent) delay:2];
}

-(Boolean) attackedByDino:(dinosaur *)otherDino{
    if(otherDino.readyToAttack){
        [otherDino.animationManager runAnimationsForSequenceNamed:@"Attacking"];
        otherDino.readyToAttack = false;
        self.health -= otherDino.attack;
        _healthLabel.string = [NSString stringWithFormat:@"%d", self.health];

        if(self.health+otherDino.attack >= KNOCKBACK_THRESHOLD && self.health < KNOCKBACK_THRESHOLD){
            [self knockback];
        }
        
        if(self.health <= 0){
            [self die];
            return true;
        }
        return false;
    }
    else{
        otherDino.attackCounter += 1;
        if(otherDino.attackCounter > otherDino.afterAttackDelay){
            otherDino.readyToAttack = true;
            otherDino.attackCounter = 0;
        }
        return false;
    }

}

-(Boolean) isEnemyNest{
    return false;
}

-(void) reverseHealthLabel{
    _healthLabel.scaleX = -1;
}

@end
