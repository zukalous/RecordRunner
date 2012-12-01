//
//  GameLayer.m
//  recordRunnder
//
//  Created by Hin Lam on 10/27/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - GameLayer

// GameLayer implementation
@implementation GameLayer
@synthesize player = _player;

@synthesize background;

@synthesize bombFreePool = _bombFreePool;
@synthesize bombUsedPool = _bombUsedPool;

@synthesize coinFreePool = _coinFreePool;
@synthesize coinUsedPool = _coinUsedPool;

// Helper class method that creates a Scene with the GameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        self.isTouchEnabled = YES;
        // This is where we create ALL game objects in this game layer
        // This includes gameObjects like bombs, players, background..etc.
        CGSize size = [[CCDirector sharedDirector] winSize];
        NSLog(@"height = %f width = %f", size.height, size.width);
        // Create background
        background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint=ccp(0,0);
                
        // Create player
        _player = [GameObjectPlayer initWithGameLayer:self
                                        imageFileName:@"player.png"
                                          objectSpeed:kPlayerSpeed];
        [_player moveTo:PLAYER_START_POSITION];

        [self addChild:background];
        [self addChild:_player.playerStreak];
        [self addChild:_player.gameObjectSprite];
        
        // Create bomb free pool (queue)
        _bombFreePool = [Queue initWithSize:MAX_NUM_BOMBS];
        
        // Create bomb used pool (queue)
        _bombUsedPool = [Queue initWithSize:MAX_NUM_BOMBS];
       
        // Create NUM_OBSTACLES bombs and add them to the free pool
        for (int i = 0; i < NUM_OBSTACLES; ++i) {
            Bomb * _bomb = [Bomb initWithGameLayer: self
                              imageFileName:@"Bomb.png"
                                objectSpeed:1];
            [_bomb moveTo:BOMB_START_POSITION];
            
            [_bombFreePool addObject:_bomb];
            
            // add bomb to GameLayer
            [self addChild: _bomb.gameObjectSprite];
        }
        
        // Create coin free pool (queue)
        _coinFreePool = [Queue initWithSize:MAX_NUM_COINS];
        
        // Create coin used pool (queue)
        _coinUsedPool = [Queue initWithSize:MAX_NUM_COINS];
        
        // Create NUM_REWARDS coins and add them to the free pool
        for (int i = 0; i < NUM_REWARDS; ++i) {
            Coin * _coin = [Coin initWithGameLayer:self
                              imageFileName:@"Coin.png"
                                objectSpeed:2];
            [_coin moveTo:COIN_START_POSITION];
            
            [_coinFreePool addObject:_coin];
            
            // add coin to GameLayer
            [self addChild: _coin.gameObjectSprite];
        }
    }
/*    NSLog(@"there are %d bombs", [_bombFreePool.objects count]);
    NSLog(@"there are %d coins", [_coinFreePool.objects count]);*/
    
    [self schedule: @selector(update:)];
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"

}

- (void) generateGameObject:(game_object_t) type
{
    GameObjectBase * newObject = nil;
    
    switch (type) {
        case BOMB_TYPE:
            //NSLog(@"creating a bomb");
            if ([_bombUsedPool.objects count] < MAX_NUM_BOMBS) {
                newObject = [_bombFreePool takeObject];
                if (newObject != nil) {
//                    NSLog(@"ADDING the bomb");
                    [_bombUsedPool addObject:newObject];
                }
            }
            break;
        case COIN_TYPE:
            //NSLog(@"creating a coin");
            if ([_coinUsedPool.objects count] < MAX_NUM_COINS) {
                newObject = [_coinFreePool takeObject];
                if (newObject != nil) {
//                    NSLog(@"ADDING the coin");
                    [_coinUsedPool addObject:newObject];
                }
            }
            break;
        default:
            break;
    }
}

- (void) update:(ccTime) dt
{
    [_player showNextFrame];
    
    // generate Bomb objects randomly
    if (arc4random() % RANDOM_MAX > BOMB_CREATION_THRESHOLD) {
        [self generateGameObject:(BOMB_TYPE)];
    }
    
    // generate Coin objects randomly
    if (arc4random() % RANDOM_MAX > COIN_CREATION_THRESHOLD) {
        [self generateGameObject:(COIN_TYPE)];
    }

    // render all bombs
//    NSLog(@"there are %d bombs", [_bombUsedPool.objects count]);
    for (int i = 0; i < [_bombUsedPool.objects count]; ++i) {
        [_bombUsedPool.objects[i] showNextFrame];
    }

    // render all coins
//    NSLog(@"there are %d coins", [_coinUsedPool.objects count]);
    for (int i = 0; i < [_coinUsedPool.objects count]; ++i) {
        [_coinUsedPool.objects[i] showNextFrame];
    }
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.player changeDirection];
}

@end
