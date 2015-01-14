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
    
    strandsOfYarn = 0; //start out currency at 0
    ourDinos = [[NSMutableArray alloc]init];
    enemyDinos = [[NSMutableArray alloc]init];
    numYarnsLabel = [CCLabelTTF labelWithString:@"8" fontName:@"TimesNewRomanPSMT" fontSize:24];
    numYarnsLabel.position = ccp((5./6)*screenWidth, (6./7)*screenHeight);
    [self addChild:numYarnsLabel z:1];
    
    self.chanceOfEnemySpawn = 5; //percentage of timesteps an enemy is spawned
    self.killBonus = 10;
    
    ourNest = (OurNest *) [CCBReader load:@"OurNest"];
    enemyNest = (EnemyNest *) [CCBReader load:@"EnemyNest"];
    ourNest.position = ccp(0, screenHeight/2);
    enemyNest.position = ccp(screenWidth, screenHeight/2);
    
    [self addChild:ourNest];
    [self addChild:enemyNest];
    
    // listen for swipes to the left
    UISwipeGestureRecognizer * swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeLeft];
    // listen for swipes to the right
    UISwipeGestureRecognizer * swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRight];
    // listen for swipes up
    UISwipeGestureRecognizer * swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeUp];
    // listen for swipes down
    UISwipeGestureRecognizer * swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];
    
    
    
//    self.gestureDetectorView = [[WTMGlyphDetectorView alloc] initWithFrame:[[CCDirector sharedDirector] view].bounds];
//    self.gestureDetectorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.gestureDetectorView.delegate = self;
//    [self.gestureDetectorView loadTemplatesWithNames: @"circle", @"square", nil];
//    [[[CCDirector sharedDirector] view] addSubview:self.gestureDetectorView];
}


-(void)spawnEnemyDino{
    dinosaur *newDino = (dinosaur*)[CCBReader load:@"dinosaur"];
    newDino.position = enemyNest.position;
    [enemyDinos addObject:newDino];
    [self addChild: newDino];

}

-(void)spawnRaptorDino{
    Raptor *newDino = (Raptor*)[CCBReader load:@"Raptor"];
    newDino.position = ourNest.position;
    [ourDinos addObject:newDino];
    [self addChild: newDino];
}

-(void)spawnTriceratops{
    dinosaur *newDino = (Triceratops*)[CCBReader load:@"Triceratops"];
    newDino.position = ourNest.position;
    [ourDinos addObject:newDino];
    [self addChild: newDino];
}

-(void)spawnAllosaurus{
    dinosaur *newDino = (Allosaurus*)[CCBReader load:@"Allosaurus"];
    newDino.position = ourNest.position;
    [ourDinos addObject:newDino];
    [self addChild: newDino];
}

-(void)spawnPterodactyl{
    dinosaur *newDino = (Pterodactyl*)[CCBReader load:@"Pterodactyl"];
    newDino.position = ourNest.position;
    [ourDinos addObject:newDino];
    [self addChild: newDino];
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
        [self spawnEnemyDino];
    }
}

- (void)swipeLeft {
    CCLOG(@"swipeLeft");
}
- (void)swipeRight {
    CCLOG(@"swipeRight");
}
- (void)swipeDown {
    CCLOG(@"swipeDown");
}
- (void)swipeUp {
    CCLOG(@"swipeUp");
}


// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
}


@end
