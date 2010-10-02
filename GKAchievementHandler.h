//
//  GKAchievementHandler.h
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <Foundation/Foundation.h>
#import "GKAchievementNotification.h"

@interface GKAchievementHandler : NSObject <GKAchievementHandlerDelegate>
{
    UIView         *_topView;
    NSMutableArray *_queue;
    UIImage        *_image;
}

@property (nonatomic, retain) UIImage *image;

+ (GKAchievementHandler *)defaultHandler;

- (void)notifyAchievement:(GKAchievementDescription *)achievement;
- (void)notifyAchievementMessage:(NSString *)message;

@end
