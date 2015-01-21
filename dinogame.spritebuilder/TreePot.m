//
//  TreePot.m
//  dinogame
//
//  Created by Laura Breiman on 1/19/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "TreePot.h"


@implementation TreePot


-(void) grow{
    if(small.visible == true){
        small.visible = false;
        medium.visible = true;
    }
    else if(medium.visible == true){
        medium.visible = false;
        big.visible = true;
    }
    else if(big.visible == true){
        big.visible = false;
    }
    else{
        small.visible = true;
    }
}

@end
