//
//  GKAchievementNotification.h
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <UIKit/UIKit.h>

@class GKAchievementNotification;

#define kGKAchievementAnimeTime     0.4f
#define kGKAchievementDisplayTime   1.75f

#define kGKAchievementDefaultSize   CGRectMake(0.0f, 0.0f, 284.0f, 52.0f);
#define kGKAchievementFrameStart    CGRectMake(18.0f, -53.0f, 284.0f, 52.0f);
#define kGKAchievementFrameEnd      CGRectMake(18.0f, 10.0f, 284.0f, 52.0f);

#define kGKAchievementText1         CGRectMake(10.0, 6.0f, 264.0f, 22.0f);
#define kGKAchievementText2         CGRectMake(10.0, 20.0f, 264.0f, 22.0f);
#define kGKAchievementText1WLogo    CGRectMake(45.0, 6.0f, 229.0f, 22.0f);
#define kGKAchievementText2WLogo    CGRectMake(45.0, 20.0f, 229.0f, 22.0f);

@protocol GKAchievementHandlerDelegate <NSObject>

@optional

- (void)didHideAchievementNotification:(GKAchievementNotification *)notification;
- (void)didShowAchievementNotification:(GKAchievementNotification *)notification;

- (void)willHideAchievementNotification:(GKAchievementNotification *)notification;
- (void)willShowAchievementNotification:(GKAchievementNotification *)notification;

@end

@interface GKAchievementNotification : UIView
{
    GKAchievementDescription  *_achievement;

    NSString *_message;  /**< Optional custom achievement message. */
    NSString *_title;    /**< Optional custom achievement title. */

    UIImageView  *_background;
    UIImageView  *_logo;

    UILabel      *_textLabel;
    UILabel      *_detailLabel;

    id<GKAchievementHandlerDelegate> _handlerDelegate;
}

@property (nonatomic, retain) GKAchievementDescription  *achievement;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIImageView *logo;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UILabel *detailLabel;
@property (nonatomic, retain) id<GKAchievementHandlerDelegate>  handlerDelegate;

- (id)initWithAchievementDescription:(GKAchievementDescription *)achievement;
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;
- (void)animateIn;
- (void)animateOut;
- (void)setImage:(UIImage *)image;

@end
