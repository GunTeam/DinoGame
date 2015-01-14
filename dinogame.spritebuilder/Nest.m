//
//  Nest.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Nest.h"


@implementation Nest

-(void) didLoadFromCCB{
    self.health = 1000;
    self.speed = 0; //nest does not move
    self.inAir =true; //default
    ATTACK_THRESHOLD = 0; //number of pix between this dino and its attack target. ptero attacks right over it
    
    self.attack = 0;
    self.readyToAttack = false; //nest never attacks
}

@end
