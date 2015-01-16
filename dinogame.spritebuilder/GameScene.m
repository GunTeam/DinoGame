//
//  GameScene.m
//  dinogame
//
//  Created by Laura Breiman on 1/7/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "GameScene.h"

dinosaur *dino;

@implementation GameScene{
CCPhysicsNode *_physicsNode;
}
@synthesize glyphDetector;

-(void) didLoadFromCCB {
    self.userInteractionEnabled = true;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
    
    //adjust for ipad sizing:
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        screenWidth = screenWidth/2;
        screenHeight = screenHeight/2;
    }
    
    strandsOfYarn = 200; //start out currency at 200
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
    numYarnsLabel = [CCLabelTTF labelWithString:@"8" fontName:@"TimesNewRomanPSMT" fontSize:24];
    numYarnsLabel.position = ccp((5./6)*screenWidth, (6./7)*screenHeight);
    [self addChild:numYarnsLabel z:1];
    
    self.chanceOfEnemySpawn = 5; //percentage of timesteps an enemy is spawned
    
    ourNest = (OurNest *) [CCBReader load:@"OurNest"];
    enemyNest = (EnemyNest *) [CCBReader load:@"EnemyNest"];
    ourNest.position = ccp(0, screenHeight/2);
    enemyNest.position = ccp(screenWidth, screenHeight/2);
    
    [self addChild:ourNest];
    [self addChild:enemyNest];
    [ourDinos addObject:ourNest];
    [enemyDinos addObject:enemyNest];
    
}


-(void)spawnEnemyDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = enemyNest.position;
    int enemyCount = [enemyDinos count];
    [enemyDinos insertObject:newDino atIndex:enemyCount-2];
    [self addChild: newDino];
}

-(void)spawnRaptorDino{
    Raptor *newDino = (Raptor*)[CCBReader load:@"Raptor"];
    if(strandsOfYarn > newDino.price){
        newDino.position = ourNest.position;
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-2];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
    }
}

-(void)spawnTriceratops{
    dinosaur *newDino = (Triceratops*)[CCBReader load:@"Triceratops"];

}

-(void)spawnAllosaurus{
    dinosaur *newDino = (Allosaurus*)[CCBReader load:@"Allosaurus"];
    newDino.scaleX = -1;
    if(strandsOfYarn > newDino.price){
        newDino.position = ourNest.position;
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-2];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
    }
}

-(void)spawnPterodactyl{
    dinosaur *newDino = (Pterodactyl*)[CCBReader load:@"Pterodactyl"];
    [self addDinosaur:newDino];
    if(strandsOfYarn > newDino.price){
        newDino.position = ccp(ourNest.position.x, (3.0/4)*screenHeight);
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-2];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
    }
}

-(void)addDinosaur:(dinosaur *)newDino{
    if(strandsOfYarn > newDino.price){
        newDino.position = ourNest.position;
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-2];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
    }
}

- (void)update:(CCTime)delta
{
    //move our dinosaurs forward
    for(dinosaur *thisDino in ourDinos){
        if([enemyDinos count] != 0){
            dinosaur *firstEnemy = [enemyDinos objectAtIndex:0];
            
            if( [thisDino collidesWith:firstEnemy]){ // an attack occurs
                Boolean enemyKilled = [firstEnemy attackedByDino:thisDino];
                if(enemyKilled){
                    strandsOfYarn += firstEnemy.killBonus;
                    [enemyDinos removeObject:firstEnemy];
                }
            }
            else{
                [thisDino moveDinoForward];
            }
        }
        else{
            [thisDino moveDinoForward];
        }
    }
    
    //move the enemy dinosaurs backward
    for(dinosaur *thisEnemy in enemyDinos){
        if([ourDinos count] != 0){
            dinosaur *ourFirstDino = [ourDinos objectAtIndex:0];
            if( [thisEnemy collidesWith:ourFirstDino]){ // an attack occurs
                Boolean killed = [ourFirstDino attackedByDino:thisEnemy];
                if(killed){
                    [ourDinos removeObject:ourFirstDino];
                }
            }
            else{
                [thisEnemy moveDinoBackward];
            }
        }
        else{
            [thisEnemy moveDinoBackward];
        }

    }
    
    strandsOfYarn = strandsOfYarn + 1;
    [numYarnsLabel setString:[NSString stringWithFormat:@"Num Yarns: %i", strandsOfYarn]];
    
    float randSpawnFlag = arc4random()%1000;
    if(randSpawnFlag < self.chanceOfEnemySpawn){
//        [self spawnEnemyDino];
    }
}


@end
