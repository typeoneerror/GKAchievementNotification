//
//  GKAchievementHandler.m
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <GameKit/GameKit.h>
#import "GKAchievementHandler.h"
#import "GKAchievementNotification.h"

static GKAchievementHandler *defaultHandler = nil;

#pragma mark -

@interface GKAchievementHandler(private)

- (void)displayNotification:(GKAchievementNotification *)notification;

@end

#pragma mark -

@implementation GKAchievementHandler(private)

- (void)displayNotification:(GKAchievementNotification *)notification
{
    if (self.image != nil)
    {
        [notification setImage:self.image];
    }
    else
    {
        [notification setImage:nil];
    }

    /** when in landscape mode, adding notification view to the topview is the easiest way to get the nofitication displayed in landscape mode instead of setting view.transform manually */
    if(_keyWindow.rootViewController) {
        [_keyWindow.rootViewController.view addSubview:notification];
    }
    else {
        [_keyWindow addSubview:notification];
    }
    [notification animateIn];
}

@end

#pragma mark -

@implementation GKAchievementHandler

@synthesize image=_image;

#pragma mark -

+ (GKAchievementHandler *)defaultHandler
{
    if (!defaultHandler) defaultHandler = [[self alloc] init];
    return defaultHandler;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
        _queue = [[NSMutableArray alloc] initWithCapacity:0];
        self.image = [UIImage imageNamed:@"gk-icon.png"];
    }
    return self;
}

- (void)dealloc
{
//    [_queue release];
//    [_image release];
 //   [super dealloc];
}

#pragma mark -

- (void)notifyAchievement:(GKAchievementDescription *)achievement
{
    GKAchievementNotification *notification = [[GKAchievementNotification alloc] initWithAchievementDescription:achievement];
    notification.handlerDelegate = self;

    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

- (void)notifyAchievementTitle:(NSString *)title andMessage:(NSString *)message
{
    GKAchievementNotification *notification = [[GKAchievementNotification alloc] initWithTitle:title andMessage:message];
    notification.handlerDelegate = self;

    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

- (void)notifyAchievementTitleAndIcon:(NSString *)title andMessage:(NSString *)message withIcon:(UIImage*)icon {
    GKAchievementNotification *notification = [[GKAchievementNotification alloc] initWithTitle:title andMessage:message];
    
    notification.handlerDelegate = self;
    [notification setImage:icon];
    
    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

- (void)notifyAchievementTitleAndIcon:(GKAchievementNotification*)notification {
    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

#pragma mark -
#pragma mark GKAchievementHandlerDelegate implementation

- (void)didHideAchievementNotification:(GKAchievementNotification *)notification
{
    [_queue removeObjectAtIndex:0];
    if ([_queue count])
    {
        [self displayNotification:(GKAchievementNotification *)[_queue objectAtIndex:0]];
    }
}

@end
