//
//  TreePot.h
//  dinogame
//
//  Created by Laura Breiman on 1/19/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TreePot : CCSprite {
    CCSprite *small, *medium, *big;
}

-(void) grow;

@end
