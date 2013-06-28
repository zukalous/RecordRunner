//
//  Coin.m
//  RecordRunnerARC
//
//  Created by Matt Cleveland on 11/12/12.
//
//

#import "Coin.h"
#import "GameLayer.h"
#import "SimpleAudioEngine.h"
#import "GameInfoGlobal.h"

@implementation Coin

@synthesize emitter=emitter_;
@synthesize bouncing = _bouncing;
@synthesize isDead = _isDead;

// -----------------------------------------------------------------------------------
- (id) init
{
    if( (self=[super init]) )
    {
        _bouncing = NO;
        _isDead = NO;
    }
    return (self);
}


- (void) didLoadFromCCB
{
    // Setup a delegate method for the animationManager of the explosion
    CCBAnimationManager* animationManager = self.userObject;
    animationManager.delegate = self;
}


// -----------------------------------------------------------------------------------
- (void) showNextFrame
{
    // this is a negative movement down the Y-axis, the Coin is falling
    // from the top of the screen
    //[self moveBy:ccp(0, self.gameObjectSpeed)];
    [self moveTo:COMMON_GET_NEW_RADIAL_POINT(COMMON_RECORD_CENTER,self.radius,self.angleRotated)];
    self.angleRotated = self.angleRotated + self.gameObjectAngularVelocity;
    [self encounterWithPlayer];
    
/*    if ([self encounterWithPlayer])
    {
        [self handleCollision];
    }
    else
    {
//        [self recycleOffScreenObjWithUsedPool:[GameLayer sharedGameLayer].coinUsedPool
//                                     freePool:[GameLayer sharedGameLayer].coinFreePool];
    }*/
}

// -----------------------------------------------------------------------------------
- (void) handleCollision
{
    [[[GameInfoGlobal sharedGameInfoGlobal].statsContainer at:COIN_STATS] tick];

    if (!_isDead)
    {
        if ([GameLayer sharedGameLayer].isDebugMode == YES)
            return;
        
        _isDead = YES;
        
        [self.animationManager runAnimationsForSequenceNamed:@"Die"];
        
        // increment score
        [GameInfoGlobal sharedGameInfoGlobal].numCoinsThisLife++;
        [[GameLayer sharedGameLayer].score incrementScore:1];
        [GameInfoGlobal sharedGameInfoGlobal].coinsThisScratch++;
        [[SimpleAudioEngine sharedEngine] playEffect:@"pickup_coin.wav"];
    }
    
}

// -----------------------------------------------------------------------------------
-(void) bounce
{
    [self.animationManager runAnimationsForSequenceNamed:@"QuickBounce"];
}

// -----------------------------------------------------------------------------------
/*-(void) scaleMe:(double)factor
{
    if (factor < 0) {
        return;
    }
    
    double scaleFactor = factor+1;//1 + (3*factor);
//    NSLog(@"scaling to: %f", scaleFactor);
//    CCSprite * coinImage;
//    NSLog(@"coin position, x: %f y: %f ", coinImage.position.x, coinImage.position.y);
    //self.gameObjectSprite.anchorPoint = ccp( 0.5, 0.5 );
    //id myAction  = [CCScaleTo actionWithDuration:0.01 scale:scaleFactor];
    //[self runAction:[CCSequence actions:myAction, nil]];
    //[self.gameObjectSprite runAction:myAction];
    self.scaleX = scaleFactor;
    self.scaleY = scaleFactor;
}*/

// -----------------------------------------------------------------------------------
- (void) resetObject
{
    _isDead = NO;
    [super resetObject];
}

- (void) completedAnimationSequenceNamed:(NSString *)name
{
    
    if (_isDead)
    {
        [self recycleObjectWithUsedPool:[GameLayer sharedGameLayer].coinUsedPool                  freePool:[GameLayer sharedGameLayer].coinFreePool];
        

    }
    
    //    [[GameLayer sharedGameLayer] unschedule:@selector(update:)];
    //    [[CCDirector sharedDirector] pause];
}

@end
