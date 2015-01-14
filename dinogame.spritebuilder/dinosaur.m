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
    self.health = 100;
    self.attack = 10;
    self.speed = 0.01; //default
    ATTACK_THRESHOLD = 10; //number of pix between this dino and its attack target. e.g. some dinosaurs get closer than others to their enemy
    self.readyToAttack = true;
    self.afterAttackDelay = 60;
    self.price = 200;
}

-(void) moveDinoForward{
    self.position = ccp( self.position.x + 100*self.speed, self.position.y );
//    CCLOG(@"%i", self.position.x);
}

-(void) moveDinoBackward{
    self.position = ccp( self.position.x - 100*self.speed, self.position.y );
}

-(Boolean) collidesWith:(dinosaur *)enemyDino{
    if( abs(enemyDino.position.x - self.position.x) <= ATTACK_THRESHOLD){
        return true;
    }
    return false;
}

-(void) attackDino:(dinosaur *)enemyDino{
    enemyDino.health -= self.attack;
}

-(Boolean) attackedByDino:(dinosaur *)enemyDino{
    if(enemyDino.readyToAttack){
        enemyDino.readyToAttack = false;
        self.health -= enemyDino.attack;
        if(self.health <= 0){
            [self removeFromParent];
            return true;
        }
        return false;
    }
    else{
        enemyDino.attackCounter += 1;
        if(enemyDino.attackCounter > enemyDino.afterAttackDelay){
            enemyDino.readyToAttack = true;
        }
    }

}

@end
