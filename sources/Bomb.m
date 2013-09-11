//
//  Bomb.m
//  RecordRunnerARC
//
//  Created by Matt Cleveland on 11/12/12.
//
//

#import "GameLayer.h"
#import "Bomb.h"
#import "CCBReader.h"
#import "GameInfoGlobal.h"
#import "GameObjectPlayer.h"

@implementation Bomb
@synthesize gameObjectUpdateTick;
@synthesize closeCallAbove;
@synthesize closeCallBelow;
@synthesize bombTimeLeft;
@synthesize exploded;

// -----------------------------------------------------------------------------------
- (id) init
{
    if( (self=[super init]) )
    {
        gameObjectUpdateTick = 0;
        closeCallAbove = NO;
        closeCallBelow = NO;
        self.radiusHitBox = (COMMON_GRID_WIDTH/4);
    }
    
    bombTimeLeft = 100;
    exploded = NO;
    
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
    [self moveTo:COMMON_GET_NEW_RADIAL_POINT(COMMON_RECORD_CENTER,self.radius,self.angleRotated)];
    self.angleRotated = self.angleRotated + self.gameObjectAngularVelocity;
    gameObjectUpdateTick++;
    
    
    // if we do not hit the player now and the player is moving, see if we
    // have a "close call"
    if (![self encounterWithPlayer] &&
        (![[GameLayer sharedGameLayer].player isIdle] ||
         [[GameLayer sharedGameLayer].player justStartedMoving])) {
        
        float distance = ccpDistance([GameLayer sharedGameLayer].player.position,
                                     self.position);
        
        // increment the score muliplier if we had a close call
        // But don't increment if the shield is active.
        if (abs(distance - self.radiusHitBox) < CLOSE_HIT_THRESHOLD_PIXEL &&
            ![GameLayer sharedGameLayer].player.hasShield) {
            
            // see if we are above or below the player
            int angleRelation = (int)self.angleRotated % 360;
            
            BOOL uniqueHit = NO;
            //if (angleRelation > (360 - CLOSE_HIT_THRESHOLD_PIXEL)) {
            if (angleRelation < 360 && angleRelation > 300) {
                if (!closeCallAbove) {
                    closeCallAbove = YES;
                    uniqueHit = YES;
                    
                    //Play sound effect
                    [[SoundController sharedSoundController] playSoundIdx:SOUND_BOMB_SKIM fromObject:self];
                    
                    NSString * multVal =
                        [NSString stringWithFormat:@"x%d",                                         [GameInfoGlobal sharedGameInfoGlobal].closeCallMultiplier];
                    
                    //Show those ghost score text above the bomb.
                    [[GameLayer sharedGameLayer] showScoreOnTrack:TRACKNUM_FROM_RADIUS
                            message: multVal displayEffect:small];
                }
            } else {
                if (!closeCallBelow) {
                    closeCallBelow = YES;
                    uniqueHit = YES;
                    
                    //Play sound effect
                    [[SoundController sharedSoundController] playSoundIdx:SOUND_BOMB_SKIM2 fromObject:self];
                    
                    //Show the multiplier
                    NSString * multVal =
                        [NSString stringWithFormat:@"x%d",                                         [GameInfoGlobal sharedGameInfoGlobal].closeCallMultiplier];
                    
                    [[GameLayer sharedGameLayer] showScoreOnTrack:TRACKNUM_FROM_RADIUS
                            message: multVal displayEffect:small];

                }
            }
            
            // only update multiplier and run animations if this is the first time
            // we've triggered the close call on this side
            if (uniqueHit) {
                [[GameLayer sharedGameLayer].multiplier incrementMultiplier:
                    [GameInfoGlobal sharedGameInfoGlobal].closeCallMultiplier];
                
                [GameInfoGlobal sharedGameInfoGlobal].closeCallsThisLife++;
                
                if (![GameInfoGlobal sharedGameInfoGlobal].clockwiseThenCounterclockwise &&
                    closeCallAbove && closeCallBelow) {
                    
                    [GameInfoGlobal sharedGameInfoGlobal].clockwiseThenCounterclockwise = YES;
                }

                if ([GameLayer sharedGameLayer].player.direction == kMoveInToOut)
                {
                    
                   [self.animationManager runAnimationsForSequenceNamed:@"CounterClockWiseRotation"];
                }
                else 
                {
                    [self.animationManager runAnimationsForSequenceNamed:@"ClockWiseRotation"];
                }
            }
        }
    }
    
    // reset close call flag when on other side of the record
    if (closeCallBelow || closeCallAbove) {
        int location = (int)self.angleRotated % 360;

        if (location > 180 && location < 200) {
            closeCallAbove = NO;
            closeCallBelow = NO;
        }
    }
}

// -----------------------------------------------------------------------------------
- (void) handleCollision
{
    if ([GameLayer sharedGameLayer].isDebugMode == YES)
        return;
    
    [self recycleObjectWithUsedPool:[GameLayer sharedGameLayer].bombUsedPool
                           freePool:[GameLayer sharedGameLayer].bombFreePool];

    // if the player has a shield (invincible), act accordingly
    if ([GameLayer sharedGameLayer].player.hasShield) {
        
        [[SoundController sharedSoundController] playSoundIdx:SOUND_BOMB_INV_PICKUP fromObject:self];
        [[[GameInfoGlobal sharedGameInfoGlobal].statsContainer at:BOMB_STATS] tick];
        [GameInfoGlobal sharedGameInfoGlobal].bombsKilledThisShield++;
        NSLog(@"Bomb absorbed by player's shield!");
        
    } else if ([GameLayer sharedGameLayer].player.hasBombAbsorber) {
        
        // if the player has the bomb-absorbing shield, deactivate it
        [[GameLayer sharedGameLayer].player DeactivateBombShield ];
        
    } else {
        //PLAYER DIES -------------------------
        [[GameLayer sharedGameLayer] gameOver];
    }
}

// -----------------------------------------------------------------------------------
//When the player gets the invincible start, all bombs turn colors.
- (void) makeInvincible
{
    [self.animationManager runAnimationsForSequenceNamed:@"InvincibleFlip"];
}

// -----------------------------------------------------------------------------------
//When the player no longer has the power.
- (void) makeVincible
{
    [self.animationManager runAnimationsForSequenceNamed:@"Rotation"];
}

// -----------------------------------------------------------------------------------
- (void) resetObject
{
    [super resetObject];
    gameObjectUpdateTick = 0;
}


// -----------------------------------------------------------------------------------
- (void) completedAnimationSequenceNamed:(NSString *)name
{
    
}




@end
