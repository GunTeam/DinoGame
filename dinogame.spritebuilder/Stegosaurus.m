//
//  Stegosaurus.m
//  dinogame
//
//  Created by Laura Breiman on 1/20/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Stegosaurus.h"


@implementation Stegosaurus

-(void) didLoadFromCCB{
    self.isEnemy = false;
    MAX_HEALTH = 100;
    self.health = MAX_HEALTH;
    KNOCKBACK_THRESHOLD = MAX_HEALTH/2; //point at which the dino gets knocked back
    _healthLabel.string = [NSString stringWithFormat:@"%d", self.health];
    self.attack = 10;
    self.speed = 0.02; //default
    ATTACK_THRESHOLD = 10; //number of pix between this dino and its attack target. e.g. some dinosaurs get closer than others to their enemy
    self.readyToAttack = true;
    self.afterAttackDelay = 60;
    self.attackCounter = 0;
    self.price = 200;
    self.killBonus = 10;
}

@end
