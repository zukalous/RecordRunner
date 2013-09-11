//
//  PowerUp.h
//  Rotato
//
//  Created by Matt Cleveland on 8/25/13.
//
//

#import <Foundation/Foundation.h>

#define MULTIPLIER_BASE_COOLDOWN_TIME_SEC   4

#define TOP_GREEN    1
#define TOP_RED      2
#define TOP_BLUE     3
#define BOTTOM_GREEN 4
#define BOTTOM_RED   5
#define BOTTOM_BLUE  6

@interface PowerUp : NSObject

// these should be in order corresponding to the #defines above
// indicating the tile order on the power up screen
typedef enum {
    BLANK_SPACE, //Used for the menu at the top.
    RECORD_SPINS_SLOWER,
    CLOSE_CALL_TIMES_2,
    START_WITH_SHIELD,
    INCREASE_STAR_SPAWN_RATE,
    MINIMUM_MULTIPLIER_OF_3,
    DOUBLE_COINS,
    numPowerUps

} PowerUpType;

typedef enum {
    IS_AVAIL_OK = 0,
    IS_AVAIL_NOT_ENOUGH_MONEY,
    IS_AVAIL_ALREADY_CHOOSEN,
    IS_AVAIL_INVALID_POWER_TYPE
}IS_AVAIL_REASON;

#define PRICE_BLANK_SPACE 0
#define PRICE_RECORD_SPINS_SLOWER 10
#define PRICE_INCREASE_STAR_SPAWN_RATE 20
#define PRICE_CLOSE_CALL_TIMES_2  100
#define PRICE_MINIMUM_MULTIPLIER_OF_3 60
#define PRICE_START_WITH_SHIELD 20
#define PRICE_DOUBLE_COINS 30

#define DESCRIPTION_BLANK_SPACE @""
#define DESCRIPTION_RECORD_SPINS_SLOWER @"Slow the record"
#define DESCRIPTION_INCREASE_STAR_SPAWN_RATE @"More stars"
#define DESCRIPTION_CLOSE_CALL_TIMES_2  @"A near miss gives x2"
#define DESCRIPTION_MINIMUM_MULTIPLIER_OF_3 @"Minimum multiplier of x3"
#define DESCRIPTION_START_WITH_SHIELD @"Start with a shield"
#define DESCRIPTION_DOUBLE_COINS @"Coin doubler"


- (id) initWithType:(PowerUpType) pType;
- (BOOL) Purchase;
- (BOOL) UnPurchase;
- (BOOL) Available;
- (void) Reset;

@property (nonatomic, assign) int cost;
@property (nonatomic, assign) PowerUpType type;
@property (nonatomic, assign) bool isChoosen;

@end
