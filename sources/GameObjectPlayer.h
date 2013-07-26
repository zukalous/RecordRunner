//
//  GameObjectPlayer.h
//  recordRunnder
//
//  Created by Hin Lam on 10/27/12.
//
//

#import <Foundation/Foundation.h>
#import "common.h"
#import "GameObjectBase.h"
#import "CCBAnimationManager.h"

#define kPlayerRadialSpeed 32
#define kPlayerHitBoxSegmentWidth kPlayerSpeed
#define PLAYER_IDLE_TICKS  15
#define OUTER_RING_IDLE_THRESHOLD 120.0

typedef enum
{
    kMoveOutToIn  = -1,
    kMoveStill    =  0,
    kMoveInToOut  =  1
} direction_t;

@interface GameObjectPlayer : GameObjectBase
{
    direction_t direction;
    CCMotionStreak *playerStreak;
}
- (void) changeDirection;
- (void) startPlayer;
- (void) stopPlayer;

- (void) setSheilded: (BOOL) trigger;

- (void) blink;
- (void) killYourself;

- (BOOL) isIdle;
- (BOOL) willHitBomb;
- (BOOL) spriteInPath: (int) angle
         withWidth:(int) width;

- (int) getPlayerTrackNum;

@property (nonatomic) direction_t direction;
@property (nonatomic) int playerRadialSpeed; // How fast the player zips between center and
                                             // outer most circle
@property (nonatomic) int playerFacingAngle; // What angle is the player facing

@property (nonatomic, assign) double consecutiveSecInOuterTrack;
@property (nonatomic) BOOL hasShield;
@property (nonatomic) NSDate * arrivedAtOuterTrack;
@property (nonatomic) BOOL canMove;
@property (nonatomic, assign) int ticksIdle; // how many ticks the player has
                                             // been idle

@end
