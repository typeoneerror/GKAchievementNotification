//
//  T1EAchievementHandler.m
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "T1EAchievementHandler.h"
#import "T1EAchievementNotification.h"

static T1EAchievementHandler *defaultHandler = nil;

#pragma mark -

@interface T1EAchievementHandler(private)

- (void)displayNotification:(T1EAchievementNotification *)notification;

@end

#pragma mark -

@implementation T1EAchievementHandler(private)

- (void)displayNotification:(T1EAchievementNotification *)notification
{
    if (self.image != nil)
    {
        [notification setImage:self.image];
    }
    else
    {
        [notification setImage:nil];
    }

    [_topView addSubview:notification];
    [notification animateIn];
}

@end

#pragma mark -

@implementation T1EAchievementHandler

@synthesize image=_image;

#pragma mark -

+ (T1EAchievementHandler *)defaultHandler
{
    if (!defaultHandler) defaultHandler = [[self alloc] init];
    return defaultHandler;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _topView = [[UIApplication sharedApplication] keyWindow];
        _queue = [[NSMutableArray alloc] initWithCapacity:0];
        self.image = [UIImage imageNamed:@"gk-icon.png"];
    }
    return self;
}

- (void)dealloc
{
    [_queue release];
    [_image release];
    [super dealloc];
}

#pragma mark -

- (void)notifyAchievement:(GKAchievementDescription *)achievement
{
    T1EAchievementNotification *notification = [[[T1EAchievementNotification alloc] initWithAchievementDescription:achievement] autorelease];
    notification.frame = kGKAchievementFrameStart;
    notification.handlerDelegate = self;

    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

- (void)notifyAchievementTitle:(NSString *)title andMessage:(NSString *)message
{
    T1EAchievementNotification *notification = [[[T1EAchievementNotification alloc] initWithTitle:title andMessage:message] autorelease];
    notification.frame = kGKAchievementFrameStart;
    notification.handlerDelegate = self;

    [_queue addObject:notification];
    if ([_queue count] == 1)
    {
        [self displayNotification:notification];
    }
}

#pragma mark -
#pragma mark T1EAchievementHandlerDelegate implementation

- (void)didHideAchievementNotification:(T1EAchievementNotification *)notification
{
    [_queue removeObjectAtIndex:0];
    if ([_queue count])
    {
        [self displayNotification:(T1EAchievementNotification *)[_queue objectAtIndex:0]];
    }
}

@end
