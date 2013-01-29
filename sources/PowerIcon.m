//
//  PowerIcon.m
//  RecordRunnerARC
//
//  Created by Matt Cleveland on 1/15/13.
//
//

#import "PowerIcon.h"

@implementation PowerIcon

@synthesize type;

// -----------------------------------------------------------------------------------
+ (id) initWithGameLayer:(GameLayer *)gamelayer
           imageFileName:(NSString *)fileName
             objectSpeed:(int)speed
               powerType:(power_type_t)pType
{
    PowerIcon * objCreated = [self initWithGameLayer:gamelayer
                                    imageFileName:fileName
                                        objectSpeed:speed];
    objCreated.type = pType;
    
    return objCreated;
}

// -----------------------------------------------------------------------------------
- (void) showNextFrame
{
    // this is a negative movement down the Y-axis, the Coin is falling
    // from the top of the screen
    [self moveTo:COMMON_GET_NEW_RADIAL_POINT(COMMON_SCREEN_CENTER, self.radius,
                                             self.angleRotated)];
    self.angleRotated = self.angleRotated + self.gameObjectAngularVelocity;
    
    if ([self encounterWithPlayer]) {
        [self handleCollision];
    } else {
        // object has rotated to the point where it should be removed from the screen
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        CGPoint curPoint = [self.gameObjectSprite position];
        
        if (curPoint.y > windowSize.height) {
            NSLog(@"removing icon from pool, size is %i",
                  [self.parentGameLayer.powerIconPool.objects count]);
            [self removeFromGamePool:self.parentGameLayer.powerIconPool];
            NSLog(@"icon removed from pool, size is %i",
                  [self.parentGameLayer.powerIconPool.objects count]);
        }
    }
}

// -----------------------------------------------------------------------------------
- (void) handleCollision
{
    Power * newPower;

    // instantiate new Power object
    switch (type) {
        case fire_missle:
            NSLog(@"Creating a missle PowerUp");
            newPower = [[PowerFireMissle alloc] initWithType:fire_missle
                                                   gameLayer:self.parentGameLayer];
            break;
        case slow_down:
            NSLog(@"Slow down type");
            break;
        default:
            break;
    }
    
    // remove PowerIcon from the parent game layer
    if (![self removeFromGamePool:self.parentGameLayer.powerIconPool]) {
        NSLog(@"Failed to remove PowerIcon from icon pool");
    }
    
    // add Power object to parentGameLayer
    [newPower addPower];
}

// -----------------------------------------------------------------------------------
- (void) resetObject
{
    [super resetObject];
}

@end
