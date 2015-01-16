//
//  Nest.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Nest.h"


@implementation Nest{
    CCLabelTTF *_nestHealth;
}

-(void) didLoadFromCCB{
    self.health = 1000;
    self.speed = 0; //nest does not move
    self.inAir =true; //default
    ATTACK_THRESHOLD = 0; //number of pix between this dino and its attack target. ptero attacks right over it
    
    self.attack = 0;
    self.readyToAttack = false; //nest never attacks
}

-(Boolean) attackedByDino:(dinosaur *)otherDino{
    //    CCAnimationManager *animationManager = otherDino.userObject;
    if(otherDino.readyToAttack){
        //        [otherDino.userObject runAnimationsForSequenceNamed:@"Attacking"];
        //        [animationManager runAnimationsForSequenceNamed:@"Attacking"];
        _nestHealth.string = [NSString stringWithFormat:@"Health: %d", self.health];
        otherDino.readyToAttack = false;
        self.health -= otherDino.attack;
        
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
        }
        return false;
    }
    
}

@end
