//
//  GKAchievementNotification.h
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <UIKit/UIKit.h>

@class GKAchievementDescription;

@class GKAchievementNotification;

#define kGKAchievementAnimeTime     0.4f
#define kGKAchievementDisplayTime   1.75f

#define kGKAchievementDefaultiPhoneSize CGSizeMake(284.f, 52.f);
#define kGKAchievementDefaultiPadSize   CGSizeMake(426.f, 52.f);

#define kGKAchievementDefaultBackground @"gk-notification.png"

/*
#define kGKAchievementDefaultSize   CGRectMake(0.0f, 0.0f, 284.0f, 52.0f);
#define kGKAchievementFrameStart    CGRectMake(18.0f, -53.0f, 284.0f, 52.0f);
#define kGKAchievementFrameEnd      CGRectMake(18.0f, 10.0f, 284.0f, 52.0f);

#define kGKAchievementText1         CGRectMake(10.0, 6.0f, 264.0f, 22.0f);
#define kGKAchievementText2         CGRectMake(10.0, 20.0f, 264.0f, 22.0f);
#define kGKAchievementText1WLogo    CGRectMake(45.0, 6.0f, 229.0f, 22.0f);
#define kGKAchievementText2WLogo    CGRectMake(45.0, 20.0f, 229.0f, 22.0f);
*/

#pragma mark -

/**
 * The handler delegate responds to hiding and showing
 * of the game center notifications.
 */
@protocol GKAchievementHandlerDelegate <NSObject>

@optional

/**
 * Called on delegate when notification is hidden.
 * @param nofification  The notification view that was hidden.
 */
- (void)didHideAchievementNotification:(GKAchievementNotification *)notification;

/**
 * Called on delegate when notification is shown.
 * @param nofification  The notification view that was shown.
 */
- (void)didShowAchievementNotification:(GKAchievementNotification *)notification;

/**
 * Called on delegate when notification is about to be hidden.
 * @param nofification  The notification view that will be hidden.
 */
- (void)willHideAchievementNotification:(GKAchievementNotification *)notification;

/**
 * Called on delegate when notification is about to be shown.
 * @param nofification  The notification view that will be shown.
 */
- (void)willShowAchievementNotification:(GKAchievementNotification *)notification;

@end

#pragma mark -

/**
 * The GKAchievementNotification is a view for showing the achievement earned.
 */
@interface GKAchievementNotification : UIView
{
    GKAchievementDescription  *_achievement;  /**< Description of achievement earned. */

    NSString *_message;  /**< Optional custom achievement message. */
    NSString *_title;    /**< Optional custom achievement title. */

    UIImageView  *_background;  /**< Stretchable background view. */
    UIImageView  *_logo;        /**< Logo that is displayed on the left. */

    UILabel      *_textLabel;    /**< Text label used to display achievement title. */
    UILabel      *_detailLabel;  /**< Text label used to display achievement description. */
    
    CGPoint    _position; /* center, automatically changes according to device orientation, normally you don't need to change this */
    CGSize     _size; /* notification window size */
    
    CGPoint    _iconPosition; /* position of the icon */
    CGSize     _iconSize; /* size of the icon, default = 34 * 34 */

    CGPoint    _titlePosition; /* position of the title */
    CGSize     _titleSize; /* size of the title textbox, default = 229 * 22 */
    
    CGPoint    _descriptionPosition; /* position of the description */
    CGSize     _descriptionSize; /* size of the description box, default = 229 * 22 */
    
    /*
     background image
     */
    UIImage*  _backgroundImage;
    /*
     Strech coordinates of the background image,
     default (8.0f, 0.0f);
     */
    CGPoint    _backgroundStretch;

    id<GKAchievementHandlerDelegate> _handlerDelegate;  /**< Reference to nofification handler. */
}

/** Description of achievement earned. */
@property (nonatomic, retain) GKAchievementDescription *achievement;
/** Optional custom achievement message. */
@property (nonatomic, retain) NSString *message;
/** Optional custom achievement title. */
@property (nonatomic, retain) NSString *title;
/** Stretchable background view. */
@property (nonatomic, retain) UIImageView *background;
/** Logo that is displayed on the left. */
@property (nonatomic, retain) UIImageView *logo;
/** Text label used to display achievement title. */
@property (nonatomic, retain) UILabel *textLabel;
/** Text label used to display achievement description. */
@property (nonatomic, retain) UILabel *detailLabel;
/** Reference to nofification handler. */
@property (nonatomic, retain) id<GKAchievementHandlerDelegate> handlerDelegate;

/* notification position, automatically adjusted according to device orientation(center horizontally) */
@property (nonatomic, readonly) CGPoint position;

/* notification view size, changing this will also cause @iconSize, @titleSize and @descriptionSize to be adjusted automatically */
@property (nonatomic, readonly) CGSize  size;


@property (nonatomic, readwrite) CGSize  iconSize;

@property (nonatomic, readwrite) CGSize  titleSize;
@property (nonatomic, readwrite) CGPoint titlePosition;

@property (nonatomic, readwrite) CGSize  descriptionSize;
@property (nonatomic, readwrite) CGPoint descriptionPosition;


/* position of the icon */
@property (nonatomic, readwrite) CGPoint iconPosition;
@property (nonatomic, readwrite) CGPoint backgroundStrech;

@property (nonatomic, readonly) UIImage* backgroundImage;

#pragma mark -

/**
 * Create a notification with an achievement description.
 * @param achievement  Achievement description to notify user of earning.
 * @return a GKAchievementNoficiation view.
 */
- (id)initWithAchievementDescription:(GKAchievementDescription *)achievement;

/**
 * Create a notification with a custom title and description.
 * @param title    Title to display in notification.
 * @param message  Descriotion to display in notification.
 * @return a GKAchievementNoficiation view.
 */
- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;

/**
 * Show the notification.
 */
- (void)animateIn;

/**
 * Hide the notificaiton.
 */
- (void)animateOut;

/**
 * Change the logo that appears on the left.
 * @param image  The image to display.
 */
- (void)setImage:(UIImage *)image;


/**
 * Set the position of the notification
*/
- (void)setPosition:(CGPoint)position;
/**
 * Set the size of the notification view
 */
- (void)setSize:(CGSize)size;

/*
 * Set the background image
 */
- (void)setCustomBackgroundImage:(NSString*)background;

@end
