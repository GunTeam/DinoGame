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
}

@synthesize chanceOfEnemySpawn, level;

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
    
    _physicsNode.collisionDelegate = self;
    _physicsNode.debugDraw = true;
    
    
    level = 1.2;
    strandsOfYarn = 2000; //start out currency at 200
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
    
    self.chanceOfEnemySpawn = 3; //percentage of timesteps an enemy is spawned
    
    ourNest = (OurNest *) [CCBReader load:@"OurNest"];
    enemyNest = (EnemyNest *) [CCBReader load:@"EnemyNest"];
    ourNest.position = ccp(0, screenHeight/2);
    enemyNest.position = ccp(screenWidth, screenHeight/2);
    
    Stegosaurus *stego = (Stegosaurus*)[CCBReader load:@"Stegosaurus"];
    Triceratops *trice = (Triceratops*)[CCBReader load:@"Triceratops"];
    Pterodactyl *ptero = (Pterodactyl*)[CCBReader load:@"Pterodactyl"];
    TRex *trex = (TRex*)[CCBReader load:@"TRex"];
    Allosaurus *allos = (Allosaurus*)[CCBReader load:@"Allosaurus"];
    
    _stegoPrice.string = [NSString stringWithFormat:@"%d", stego.price];
    _tricePrice.string = [NSString stringWithFormat:@"%d", trice.price];
    _allosaurusPrice.string = [NSString stringWithFormat:@"%d", allos.price];
    _pterodactylPrice.string = [NSString stringWithFormat:@"%d", ptero.price];
    _trexPrice.string = [NSString stringWithFormat:@"%d", trex.price];
    
    [self addChild:ourNest];
    [self addChild:enemyNest];
    [ourDinos addObject:ourNest];
    [enemyDinos addObject:enemyNest];
    
    [self spawnEnemyDino];
    
}


-(void)spawnEnemyDino{
    dinosaur *newDino;
    int randSpawnFlag = arc4random()%5;
    switch (randSpawnFlag)
    {
        case 0:
            newDino = (Allosaurus*)[CCBReader load:@"EvilAllosaurus"];
            break;
        case 1:
            newDino = (TRex*)[CCBReader load:@"EvilTRex"];
            break;
        case 2:
            newDino = (Stegosaurus*)[CCBReader load:@"EvilStegosaurus"];
            break;
        case 3:
            newDino = (Triceratops*)[CCBReader load:@"EvilTriceratops"];
            break;
        case 4:
            newDino = (Pterodactyl*)[CCBReader load:@"EvilPterodactyl"];
            newDino.scaleX = -1;
            [newDino reverseHealthLabel];
            break;
        default:
            break;
            
    }
//    [self addEnemyDinosaur:newDino];
    newDino.scale = 0.8;
    if(newDino.inAir){
        newDino.position = ccp(enemyNest.position.x, (3.0/4)*screenHeight);
    }
    [newDino changeLevelMultiplier:level];
}

-(void)spawnTRex{
    TRex *newDino = (TRex*)[CCBReader load:@"TRex"];
    newDino.scale = 0.8;
    [self addOurDinosaur:newDino];
    newDino.scaleX *= -1;
    [newDino reverseHealthLabel];
}

-(void)spawnTriceratops{
    dinosaur *newDino = (Triceratops*)[CCBReader load:@"Triceratops"];
    newDino.scale = 0.8;
    [self addOurDinosaur:newDino];
    newDino.scaleX *= -1;
    [newDino reverseHealthLabel];
}

-(void)spawnStegosaurus{
    dinosaur *newDino = (Stegosaurus*)[CCBReader load:@"Stegosaurus"];
    newDino.scale = 0.8;
    [self addOurDinosaur:newDino];
    newDino.scaleX *= -1;
    [newDino reverseHealthLabel];
}

-(void)spawnAllosaurus{
    dinosaur *newDino = (Allosaurus*)[CCBReader load:@"Allosaurus"];
    newDino.scale = 0.8;
    [self addOurDinosaur:newDino];
    newDino.scaleX *= -1;
    [newDino reverseHealthLabel];
}

-(void)spawnPterodactyl{
    dinosaur *newDino = (Pterodactyl*)[CCBReader load:@"Pterodactyl"];
    newDino.scale = 0.8;
    [self addOurDinosaur:newDino];
}

-(void)addOurDinosaur:(dinosaur *)newDino{
    if(strandsOfYarn > newDino.price){
        newDino.position = ourNest.position;
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-1];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
        if(newDino.inAir){
            newDino.position = ccp(ourNest.position.x, (3.0/4)*screenHeight);
        }
    }
}

-(void)addEnemyDinosaur:(dinosaur *)newDino{
    [newDino setIsEnemy:true];
    newDino.position = enemyNest.position;
    int enemyCount = [enemyDinos count];
    [enemyDinos insertObject:newDino atIndex:enemyCount-1];
    [self addChild: newDino];
}

-(void)winLevel{
    CCLOG(@"You win");
}

-(void)loseLevel{
//    CCLOG(@"You win");

    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"]];
}

- (void) sortOurDinos{
    [ourDinos sortUsingComparator:
     ^NSComparisonResult(id firstDino, id secondDino) {
         dinosaur *d1 = (dinosaur*) firstDino;
         dinosaur *d2 = (dinosaur*) secondDino;
        if (d1.position.x < d2.position.x)
            return NSOrderedDescending;
        else if (d1.position.x > d2.position.x)
            return NSOrderedAscending;
        else
            return NSOrderedSame;
    }
     ];
}

- (void) sortEnemyDinos{
    [enemyDinos sortUsingComparator:
     ^NSComparisonResult(id firstDino, id secondDino) {
         dinosaur *d1 = (dinosaur*) firstDino;
         dinosaur *d2 = (dinosaur*) secondDino;
         if (d1.position.x < d2.position.x)
             return NSOrderedAscending;
         else if (d1.position.x > d2.position.x)
             return NSOrderedDescending;
         else
             return NSOrderedSame;
     }
     ];
}

- (void)update:(CCTime)delta
{
    if ( [ self.children indexOfObject:enemyNest ] == NSNotFound ) {
        //the enemy nest was destroyed!!
        [self winLevel];
    }
    
    if ( [ self.children indexOfObject:ourNest ] == NSNotFound ) {
        //our nest was destroyed!!
        [self loseLevel];
    }
    [self sortOurDinos];
    [self sortEnemyDinos];
    //move our dinosaurs forward
    for(dinosaur *thisDino in ourDinos){
        if([enemyDinos count] != 0){
            dinosaur *firstEnemy = [enemyDinos objectAtIndex:0];
            
            if( [thisDino collidesWith:firstEnemy]){ // an attack occurs
                Boolean enemyKilled = [firstEnemy attackedByDino:thisDino];
                if(enemyKilled){
                    strandsOfYarn += firstEnemy.killBonus;
                    [enemyDinos removeObject:firstEnemy];
//                    [firstEnemy scheduleOnce:@selector(removeFromParent) delay:2];
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
//                    [ourFirstDino scheduleOnce:@selector(removeFromParent) delay:2];
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
    [_numYarnsLabel setString:[NSString stringWithFormat:@"%i", strandsOfYarn]];
    
    float randSpawnFlag = arc4random()%1000;
    if(randSpawnFlag < self.chanceOfEnemySpawn){
        [self spawnEnemyDino];
    }

}

-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair yarn:(BallOfYarn *)ballOfYarn pot:(TreePot *) pot{
    //do stuff
    [pot grow];
    return NO;
}
@end
