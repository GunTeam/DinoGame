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
    
    strandsOfYarn = 2000; //start out currency at 200
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
    
//    ballOfYarn = (BallOfYarn*)[CCBReader load:@"BallOfYarn"];
    
    self.chanceOfEnemySpawn = 3; //percentage of timesteps an enemy is spawned
    
    ourNest = (OurNest *) [CCBReader load:@"OurNest"];
    enemyNest = (EnemyNest *) [CCBReader load:@"EnemyNest"];
    ourNest.position = ccp(0, screenHeight/2);
    enemyNest.position = ccp(screenWidth, screenHeight/2);
    
    [self addChild:ourNest];
    [self addChild:enemyNest];
    [ourDinos addObject:ourNest];
    [enemyDinos addObject:enemyNest];
    
    [self spawnEnemyDino];
    
}


-(void)spawnEnemyDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    [self addEnemyDinosaur:newDino];
}

-(void)spawnRaptorDino{
    Raptor *newDino = (Raptor*)[CCBReader load:@"Raptor"];
    [self addOurDinosaur:newDino];
}

-(void)spawnTriceratops{
    dinosaur *newDino = (Triceratops*)[CCBReader load:@"Triceratops"];
    [self addOurDinosaur:newDino];
}

-(void)spawnAllosaurus{
    dinosaur *newDino = (Allosaurus*)[CCBReader load:@"Allosaurus"];
    [self addOurDinosaur:newDino];
    newDino.scaleX = -1;
}

-(void)spawnPterodactyl{
    dinosaur *newDino = (Pterodactyl*)[CCBReader load:@"Pterodactyl"];
    [self addOurDinosaur:newDino];
    newDino.position = ccp(ourNest.position.x, (3.0/4)*screenHeight);
}

-(void)addOurDinosaur:(dinosaur *)newDino{
    if(strandsOfYarn > newDino.price){
        newDino.position = ourNest.position;
        int usCount = [ourDinos count];
        [ourDinos insertObject:newDino atIndex:usCount-1];
        [self addChild: newDino];
        strandsOfYarn -= newDino.price;
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
    [_numYarnsLabel setString:[NSString stringWithFormat:@"%i", strandsOfYarn]];
    
    float randSpawnFlag = arc4random()%1000;
    if(randSpawnFlag < self.chanceOfEnemySpawn){
        [self spawnEnemyDino];
    }
    
    if ( [ self.children indexOfObject:enemyNest ] == NSNotFound ) { //the enemy nest was destroyed!!
        [self winLevel];
    }
    
    if ( [ self.children indexOfObject:ourNest ] == NSNotFound ) { //our nest was destroyed!!
        [self loseLevel];
    }

}

-(void) ballOfYarn{
        CCSprite *newSprite = (BallOfYarn*)[CCBReader load:@"BallOfYarn"];
        newSprite.position = _yarnBallLabel.position;
        [self addChild:newSprite];
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
//    if (CGRectContainsPoint(ballOfYarn.boundingBox, touchLocation)) {
//        newSprite = (BallOfYarn*)[CCBReader load:@"BallOfYarn"];
//        newSprite.position = ourNest.position;
//        [self addChild:newSprite];
//    }
}

//-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
//    CGPoint touchLocation = [touch locationInView: [touch view]];
//    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
//    CGPoint nodeTouchLocation = [self convertToNodeSpace:touchLocation];
//    [self selectSpriteForTouch:nodeTouchLocation];
//}


@end
