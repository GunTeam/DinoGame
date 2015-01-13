//
//  Pterodactyl.m
//  dinogame
//
//  Created by Laura Breiman on 1/12/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Pterodactyl.h"


@implementation Pterodactyl

-(void) didLoadFromCCB{
    self.inAir =true; //default
    ATTACK_THRESHOLD = 0; //number of pix between this dino and its attack target. ptero attacks right over it
    
}

@end
