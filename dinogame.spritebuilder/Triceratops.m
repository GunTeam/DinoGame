//
//  Triceratops.m
//  dinogame
//
//  Created by Laura Breiman on 1/12/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Triceratops.h"


@implementation Triceratops

-(void) didLoadFromCCB{
    self.levelMultiplier = 1;
    self.isEnemy = false;
    MAX_HEALTH = 1000;
    self.health = MAX_HEALTH;
    KNOCKBACK_THRESHOLD = MAX_HEALTH/2; //point at which the dino gets knocked back
    _healthLabel.string = [NSString stringWithFormat:@"%d", self.health];
    self.attack = 5;
    self.speed = 0.01; //default
    ATTACK_THRESHOLD = 5; //number of pix between this dino and its attack target. e.g. some dinosaurs get closer than others to their enemy
    self.readyToAttack = true;
    self.afterAttackDelay = 70;
    self.attackCounter = 0;
    self.price = 200;
    self.killBonus = 10;
}


@end
