//
//  GameObjectPlayer.h
//  recordRunnder
//
//  Created by Hin Lam on 10/27/12.
//
//

#import <Foundation/Foundation.h>
#import "GameObjectBase.h"
#define kPlayerSpeed 10
typedef enum
{
    kMoveLeft  = -1,
    kMoveStill =  0,
    kMoveRight =  1
} direction_t;


@interface GameObjectPlayer : GameObjectBase
{
    direction_t direction;
    CCMotionStreak *playerStreak;
}
- (void) changeDirection;

@property (nonatomic) direction_t direction;
@property (nonatomic,strong) CCMotionStreak *playerStreak;
@end
