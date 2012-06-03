//
//  GKAchievementNotification.m
//
//  Created by Benjamin Borowski on 9/30/10.
//  Copyright 2010 Typeoneerror Studios. All rights reserved.
//  $Id$
//

#import <GameKit/GameKit.h>
#import "GKAchievementNotification.h"

#pragma mark -

@interface GKAchievementNotification(private)

- (void)animationInDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)animationOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
- (void)delegateCallback:(SEL)selector withObject:(id)object;

@end

#pragma mark -

@implementation GKAchievementNotification(private)

- (void)animationInDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self delegateCallback:@selector(didShowAchievementNotification:) withObject:self];
    [self performSelector:@selector(animateOut) withObject:nil afterDelay:kGKAchievementDisplayTime];
}

- (void)animationOutDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [self delegateCallback:@selector(didHideAchievementNotification:) withObject:self];
    [self removeFromSuperview];
}

- (void)delegateCallback:(SEL)selector withObject:(id)object
{
    if (self.handlerDelegate)
    {
        if ([self.handlerDelegate respondsToSelector:selector])
        {
            [self.handlerDelegate performSelector:selector withObject:object];
        }
    }
}

@end

#pragma mark -

@implementation GKAchievementNotification

@synthesize achievement=_achievement;
@synthesize background=_background;
@synthesize handlerDelegate=_handlerDelegate;
@synthesize detailLabel=_detailLabel;
@synthesize logo=_logo;
@synthesize message=_message;
@synthesize title=_title;
@synthesize textLabel=_textLabel;

@synthesize position=_position;
@synthesize iconPosition=_iconPosition;
@synthesize size=_size;
@synthesize iconSize=_iconSize;
@synthesize titleSize=_titleSize;
@synthesize descriptionSize=_descriptionSize;
@synthesize backgroundStrech=_backgroundStretch;
@synthesize titlePosition=_titlePosition;
@synthesize descriptionPosition=_descriptionPosition;

@synthesize backgroundImage=_backgroundImage;

#pragma mark -

- (id)initWithAchievementDescription:(GKAchievementDescription *)achievement
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _size = kGKAchievementDefaultiPadSize;
    }
    else {
        _size = kGKAchievementDefaultiPhoneSize;
    }
    
    if(![self isLandscapeView]) {
        _position.x = screen.size.width / 2 - _size.width / 2;
    } else {
        _position.x = screen.size.height / 2 - _size.width / 2;
    }
    
    _position.y = 10.f;
    CGRect frame = CGRectMake(_position.x, 
                              _position.y, 
                              _size.width, 
                              _size.height);
    self.achievement = achievement;
    if ((self = [self initWithFrame:frame]))
    {
    }
    return self;
}

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        _size = kGKAchievementDefaultiPadSize;
    }
    else {
        _size = kGKAchievementDefaultiPhoneSize;
    }
    
    /* deal with landscape modes */
    if(![self isLandscapeView]) {
        _position.x = screen.size.width / 2 - _size.width / 2;
    } else {
        _position.x = screen.size.height / 2 - _size.width / 2;
    }
    
    _position.y = 10.f;
    CGRect frame = CGRectMake(_position.x, 
                              _position.y, 
                              _size.width, 
                              _size.height);
    self.title = title;
    self.message = message;
    if (self == [self initWithFrame:frame])
    {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        _iconPosition = CGPointMake(7.0f, 6.0f);
        _iconSize = CGSizeMake(34.f, 34.f);
        
        _titlePosition = CGPointMake(10.f, 6.f);
        _titleSize = CGSizeMake(_size.width - _titlePosition.x * 2, 
                                22.f);

        _descriptionPosition = CGPointMake(10.f, 20.f);        
        _descriptionSize = CGSizeMake(_size.width - _titlePosition.x * 2, 
                                      22.f);
        
        _backgroundStretch = CGPointMake(8.0f, 0.f);
    }
    return self;
}

- (void)setupContent {
    [self setBackgroundImage:kGKAchievementDefaultBackground];
    
    CGRect r1 = CGRectMake(_titlePosition.x, 
                           _titlePosition.y, 
                           _titleSize.width, 
                           _titleSize.height);
    CGRect r2 = CGRectMake(_descriptionPosition.x,
                           _descriptionPosition.y,
                           _descriptionSize.width, 
                           _descriptionSize.height);
    
    // create the text label
    UILabel *tTextLabel = [[UILabel alloc] initWithFrame:r1];
    tTextLabel.textAlignment = UITextAlignmentCenter;
    tTextLabel.backgroundColor = [UIColor clearColor];
    tTextLabel.textColor = [UIColor whiteColor];
    tTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f];
    tTextLabel.text = NSLocalizedString(@"Achievement Unlocked", @"Achievemnt Unlocked Message");
    self.textLabel = tTextLabel;
    //       [tTextLabel release];
    
    // detail label
    UILabel *tDetailLabel = [[UILabel alloc] initWithFrame:r2];
    tDetailLabel.textAlignment = UITextAlignmentCenter;
    tDetailLabel.adjustsFontSizeToFitWidth = YES;
    tDetailLabel.minimumFontSize = 10.0f;
    tDetailLabel.backgroundColor = [UIColor clearColor];
    tDetailLabel.textColor = [UIColor whiteColor];
    tDetailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0f];
    self.detailLabel = tDetailLabel;
    //        [tDetailLabel release];
    
    if (self.achievement)
    {
        self.textLabel.text = self.achievement.title;
        self.detailLabel.text = self.achievement.achievedDescription;
    }
    else
    {
        if (self.title)
        {
            self.textLabel.text = self.title;
        }
        if (self.message)
        {
            self.detailLabel.text = self.message;
        }
    }
    
    [self addSubview:self.textLabel];
    [self addSubview:self.detailLabel];
}

- (void)dealloc
{
    NSLog(@"dealloc: GKAchievementNotification");
    
    self.handlerDelegate = nil;
    self.logo = nil;
    
//    [_achievement release];
//    [_background release];
 //   [_detailLabel release];
//    [_logo release];
//    [_message release];
//    [_textLabel release];
//    [_title release];
    
//    [super dealloc];
}


#pragma mark -

- (void)animateIn
{
    /* first setup contents with configuration */
    [self setupContent];
    
    self.frame = CGRectMake(_position.x, 
                            -self.size.height - 1, 
                            _size.width, 
                            _size.height);
    
    [self delegateCallback:@selector(willShowAchievementNotification:) withObject:self];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kGKAchievementAnimeTime];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDidStopSelector:@selector(animationInDidStop:finished:context:)];
    
    [self shouldAutorotateToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation]];

    
    self.frame = CGRectMake(_position.x, 
                            _position.y, 
                            _size.width, 
                            _size.height);
    [UIView commitAnimations];
}

- (void)animateOut
{
    [self delegateCallback:@selector(willHideAchievementNotification:) withObject:self];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kGKAchievementAnimeTime];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDidStopSelector:@selector(animationOutDidStop:finished:context:)];
    self.frame = CGRectMake(_position.x, 
                            -self.size.height - 1, 
                            _size.width, 
                            _size.height);
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)setImage:(UIImage *)image
{
    if (image)
    {
        if (!self.logo)
        {
            UIImageView *tLogo = [[UIImageView alloc] initWithFrame:CGRectMake(_iconPosition.x,
                                                                               _iconPosition.y,
                                                                               _iconSize.width,
                                                                               _iconSize.height)];
            tLogo.contentMode = UIViewContentModeCenter;
            self.logo = tLogo;
 //           [tLogo release];
            [self addSubview:self.logo];
        }
        self.logo.image = image;
        
        _titlePosition = CGPointMake(10.f + _iconSize.width + _iconPosition.x, 6.f);
        _titleSize = CGSizeMake(_size.width - _titlePosition.x - 10.f, 
                                22.f);
        
        _descriptionPosition = CGPointMake(10.f + _iconSize.width + _iconPosition.x, 20.f);        
        _descriptionSize = CGSizeMake(_size.width - _titlePosition.x - 10.f, 
                                      22.f);
        
        self.textLabel.frame = CGRectMake(_titlePosition.x, 
                                          _titlePosition.y, 
                                          _titleSize.width, 
                                          _titleSize.height);;
        self.detailLabel.frame = CGRectMake(_descriptionPosition.x,
                                            _descriptionPosition.y,
                                            _descriptionSize.width, 
                                            _descriptionSize.height);;
    }
    else
    {
        if (self.logo)
        {
            [self.logo removeFromSuperview];
        }
        
        _titlePosition = CGPointMake(10.f, 6.f);
        _titleSize = CGSizeMake(_size.width - _titlePosition.x - 10.f, 
                                22.f);
        
        _descriptionPosition = CGPointMake(10.f, 20.f);        
        _descriptionSize = CGSizeMake(_size.width - _titlePosition.x - 10.f, 
                                      22.f);
        
        self.textLabel.frame = CGRectMake(_titlePosition.x, 
                                          _titlePosition.y, 
                                          _titleSize.width, 
                                          _titleSize.height);
        self.detailLabel.frame = CGRectMake(_descriptionPosition.x,
                                            _descriptionPosition.y,
                                            _descriptionSize.width, 
                                            _descriptionSize.height);
    }
}

- (BOOL)isLandscapeView {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    return orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight;
}

- (void)setPosition:(CGPoint)position {
    _position = position;
}

- (void)setIconSize:(CGSize)iconSize {
    _iconSize = iconSize;
    if(_size.height < iconSize.height) 
        _size.height = _iconSize.height + 18.f;
}

- (void)setSize:(CGSize)size {
    _size = size;
    
    _titlePosition = CGPointMake(10.f, 6.f);
    _titleSize = CGSizeMake(_size.width - _titlePosition.x * 2, 
                            22.f);
    
    _descriptionPosition = CGPointMake(10.f, 20.f);        
    _descriptionSize = CGSizeMake(_size.width - _titlePosition.x * 2, 
                                  22.f);
}

- (void)setBackgroundImage:(NSString *)background {
    _backgroundImage = [[UIImage imageNamed:background] stretchableImageWithLeftCapWidth:_backgroundStretch.x topCapHeight:_backgroundStretch.y];
    UIImageView *tBackground = [[UIImageView alloc] initWithFrame: CGRectMake(0.f, 
                                                                              0.f, 
                                                                              _size.width, 
                                                                              _size.height)];
    tBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    tBackground.image = _backgroundImage;
    self.background = tBackground;
    self.opaque = NO;
    //   [tBackground release];
    [self addSubview:self.background];
}

@end
