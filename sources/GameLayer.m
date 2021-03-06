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
@synthesize coin = _coin;
@synthesize bomb = _bomb;
@synthesize background;

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
        
        // Create background
        background = [CCSprite spriteWithFile:@"background.png"];
        background.anchorPoint=ccp(0,0);
                
        // Create player
        _player = [GameObjectPlayer initWithGameLayer:self
                                        imageFileName:@"player.png"
                                          objectSpeed:kPlayerSpeed];
        [_player moveTo:ccp(200,
                            _player.gameObjectSprite.quad.tr.vertices.y)];

        
        // Create bomb
        _bomb = [Bomb initWithGameLayer: self
                          imageFileName:@"Bomb.png"
                            objectSpeed:1];
        [_bomb moveTo:ccp(100,
                          size.height - _bomb.gameObjectSprite.quad.tr.vertices.y)];
        
        // Create coin
        _coin = [Coin initWithGameLayer:self
                          imageFileName:@"Coin.png"
                             objectSpeed:2];
        [_coin moveTo:ccp(300,
                          size.height - _coin.gameObjectSprite.quad.tr.vertices.y)];
        
        [self addChild:background];
        [self addChild:_player.playerStreak];
        [self addChild:_player.gameObjectSprite];
        [self addChild:_coin.gameObjectSprite];
        [self addChild:_bomb.gameObjectSprite];
    }
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

- (void) update:(ccTime) dt
{
    [_player showNextFrame];
    
    [_bomb showNextFrame];
    
    [_coin showNextFrame];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.player changeDirection];
}


@end
