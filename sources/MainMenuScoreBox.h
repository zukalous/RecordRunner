//
//  MainMenuScoreBox.h
//  RecordRunnerARC
//
//  Created by Chris Zukowski on 4/2/13.
//
//

#import "CCLayer.h"


#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "MenuBox.h"

@interface MainMenuScoreBox : MenuBox <GKLeaderboardViewControllerDelegate,
    GKAchievementViewControllerDelegate>
{
    
}
- (void) pressedGameCenter: (id)sender;
- (void) pressedGameCenterAchievements: (id)sender;
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex;

@property (nonatomic, strong) UIView *gameCenterView;
@property (nonatomic, strong) UIViewController *gameCenterViewController;
@end
