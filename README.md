GKAchievementNotification
=========================

What is it?
-----------

Game Center has a notification window that slides down and informs the GKLocalPlayer that they've been authenticated. The GKAchievementNotification classes are a way to display achievements awarded to the player in the same manner; more similar to Xbox Live style achievement popups. The achievement dialogs are added to the UIWindow view of your application.

Using it
--------

Add the folder (.h, .m, images) to your Xcode project. The GKAchievementHandler class handles the display of the notifications. You'll primarily use that (there'd usually be no reason to create a notification directly). When your player earns an achievement, you can notify them of this via GKAchievementHandler:

<pre>
// grab an achievement description from where ever you saved them
GKAchievementDescription *achievement = [[GKAchievementDescription alloc] init];

// notify the user
[[GKAchievementHandler defaultHandler] notifyAchievement:achievement];
</pre>

You can also use custom messages instead of a GKAchievementDescription object:

<pre>
[[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"High Roller" andMessage:@"Earned 100 points online."];
</pre>

Customization
-------------

Apples Guidelines state that "it is up to you to do so in a way that fits the style of your game".  and Allan Schaffer of Apple stated in the forums that "[the] best way to do that would be to present a custom dialog using the look and feel of *your* game." This to me means you may be rejected for using Apple's artwork in a custom application. If this worries you, use the <code>setImage:</code> methods to change the logo displayed in the dialog or change the gk-icon.png images in your images. You can also set the image to nil to not show any image:

<pre>
[[GKAchievementHandler defaultHandler] setImage:nil];
</pre>

You can also edit the gk-notification.png images to change the stretchable background.