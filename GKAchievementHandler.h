//
//  GKAchievementHandler.h
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <Foundation/Foundation.h>
#import "GKAchievementNotification.h"

/**
 * Game Center has a notification window that slides down and informs the GKLocalPlayer 
 * that they've been authenticated. The GKAchievementNotification classes are a way to 
 * display achievements awarded to the player in the same manner; more similar to Xbox Live 
 * style achievement popups. The achievement dialogs are added to the UIWindow view of your application.
 *
 * The GKAchievementHandler is a singleton pattern that you can use to 
 * notify the user anywhere in your application that they earned an achievement.
 */
@interface GKAchievementHandler : NSObject <GKAchievementHandlerDelegate>
{
    UIView         *_topView;  /**< Reference to top view of UIApplication. */
    NSMutableArray *_queue;    /**< Queue of achievement notifiers to display. */
    UIImage        *_image;    /**< Logo to display in notifications. */
}

/** Logo to display in notifications. */
@property (nonatomic, retain) UIImage *image;

/**
 * Returns a reference to the singleton GKAchievementHandler.
 * @return a single GKAchievementHandler.
 */
+ (GKAchievementHandler *)defaultHandler;

/**
 * Show an achievement notification with an actual achievement.
 * @param achievement  Achievement description object to notify user of.
 */
- (void)notifyAchievement:(GKAchievementDescription *)achievement;

/**
 * Show an achievement notification with a message manually added.
 * @param title    The title of the achievement.
 * @param message  Description of the achievement.
 */
- (void)notifyAchievementTitle:(NSString *)title andMessage:(NSString *)message;

@end
