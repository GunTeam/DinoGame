//
//  dinosaur.h
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface dinosaur : CCSprite {
}

@property int health;
@property int speed;
@property int attack;
@property Boolean inAir;

@end
