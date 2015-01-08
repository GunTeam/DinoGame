//
//  dinosaur.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "dinosaur.h"

@implementation dinosaur

@synthesize health, speed, attack, inAir;

-(void) didLoadFromCCB{
    self.speed = 0.01; //default
    ATTACK_THRESHOLD = 10; //number of pix between this dino and its attack target. e.g. some dinosaurs get closer than others to their enemy
}

-(void) moveDinoForward{
    self.position = ccp( self.position.x + 100*self.speed, self.position.y );
//    CCLOG(@"%i", self.position.x);
}

-(void) moveDinoBackward{
    self.position = ccp( self.position.x - 100*self.speed, self.position.y );
}

-(Boolean) collidesWith:(dinosaur *)enemyDino{
    if( abs(enemyDino.position.x - self.position.x) <=10){
        return true;
    }
    return false;
}

@end
