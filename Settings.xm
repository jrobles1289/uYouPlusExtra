#import "Tweaks/YouTubeHeader/YTSettingsViewController.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItem.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItemManager.h"
#import "Header.h"

@interface YTSettingsSectionItemManager (YouPiP)
- (void)updateuYouPlusSectionWithEntry:(id)entry;
@end

static const NSInteger uYouPlusSection = 500;

extern NSBundle *uYouPlusBundle();
extern BOOL hideHUD();
extern BOOL oled();
extern BOOL oledKB();
extern BOOL autoFullScreen();
extern BOOL hideHoverCard();
extern BOOL reExplore();
extern BOOL bigYTMiniPlayer();
extern BOOL hideCC();
extern BOOL hideAutoplaySwitch();
extern BOOL castConfirm();
extern BOOL ytMiniPlayer();
extern BOOL hidePreviousAndNextButton();
extern BOOL hidePaidPromotionCard();
extern BOOL ytDisableHighContrastIcons();
extern BOOL ytOldIconStyle();
extern BOOL ytNotificationFix();
extern BOOL BlueIcons();
extern BOOL RedIcons();
extern BOOL OrangeIcons();
extern BOOL PinkIcons();
extern BOOL PurpleIcons();
extern BOOL GreenIcons();

// Settings
%hook YTAppSettingsPresentationData
+ (NSArray *)settingsCategoryOrder {
    NSArray *order = %orig;
    NSMutableArray *mutableOrder = [order mutableCopy];
    NSUInteger insertIndex = [order indexOfObject:@(1)];
    if (insertIndex != NSNotFound)
        [mutableOrder insertObject:@(uYouPlusSection) atIndex:insertIndex + 1];
    return mutableOrder;
}
%end

%hook YTSettingsSectionItemManager
%new 
- (void)updateuYouPlusSectionWithEntry:(id)entry {
    YTSettingsViewController *delegate = [self valueForKey:@"_dataDelegate"];
    NSBundle *tweakBundle = uYouPlusBundle();

    YTSettingsSectionItem *GreenIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Green UI" titleDescription:@"Green UI (have every other ui colors off) App restart is required."];
    GreenIcons.hasSwitch = YES;
    GreenIcons.switchVisible = YES;
    GreenIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"GreenIcons_enabled"];
    GreenIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"GreenIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *PurpleIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Purple UI" titleDescription:@"Purple UI (have every other ui colors off) App restart is required."];
    PurpleIcons.hasSwitch = YES;
    PurpleIcons.switchVisible = YES;
    PurpleIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"PurpleIcons_enabled"];
    PurpleIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"PurpleIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *PinkIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Pink UI" titleDescription:@"Pink UI (have every other ui colors off) App restart is required."];
    PinkIcons.hasSwitch = YES;
    PinkIcons.switchVisible = YES;
    PinkIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"PinkIcons_enabled"];
    PinkIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"PinkIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *OrangeIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Orange UI" titleDescription:@"Orange UI (have every other ui colors off) App restart is required."];
    OrangeIcons.hasSwitch = YES;
    OrangeIcons.switchVisible = YES;
    OrangeIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"OrangeIcons_enabled"];
    OrangeIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"OrangeIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *RedIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Red UI" titleDescription:@"Red UI (have every other ui colors off) App restart is required."];
    RedIcons.hasSwitch = YES;
    RedIcons.switchVisible = YES;
    RedIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"RedIcons_enabled"];
    RedIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"RedIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *BlueIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"Blue UI") titleDescription:LOC(@"Blue UI (have every other ui colors off) App restart is required.")];
    BlueIcons.hasSwitch = YES;
    BlueIcons.switchVisible = YES;
    BlueIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"BlueIcons_enabled"];
    BlueIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"BlueIcons_enabled"];
        return YES;
    };
    
    YTSettingsSectionItem *ytNotificationFix = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Solve Notification Crash on uYou 2.1 (ytNotificationFix)" titleDescription:@"Tries its best to solve a uYou crash and App restart is required."];
    ytNotificationFix.hasSwitch = YES;
    ytNotificationFix.switchVisible = YES;
    ytNotificationFix.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytNotificationFix_enabled"];
    ytNotificationFix.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
       [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytNotificationFix_enabled"];
       return YES;
    };
    
    YTSettingsSectionItem *ytOldIconStyle = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Monochromatic Icons (YTOldIconStyle)" titleDescription:@"YTDisableHighContrastIcons must be enabled and App restart is required."];
    ytOldIconStyle.hasSwitch = YES;
    ytOldIconStyle.switchVisible = YES;
    ytOldIconStyle.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytOldIconStyle_enabled"];
    ytOldIconStyle.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
       [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytOldIconStyle_enabled"];
       return YES;
    };

    YTSettingsSectionItem *ytDisableHighContrastIcons = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Revert The High Contrast Icons (YTDisableHighContrastIcons)" titleDescription:@"App restart is required."];
    ytDisableHighContrastIcons.hasSwitch = YES;
    ytDisableHighContrastIcons.switchVisible = YES;
    ytDisableHighContrastIcons.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytDisableHighContrastIcons_enabled"];
    ytDisableHighContrastIcons.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytDisableHighContrastIcons_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hidePaidPromotionCard = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_PAID_PROMOTION_CARDS") titleDescription:LOC(@"HIDE_PAID_PROMOTION_CARDS_DESC")];
    hidePaidPromotionCard.hasSwitch = YES;
    hidePaidPromotionCard.switchVisible = YES;
    hidePaidPromotionCard.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hidePaidPromotionCard_enabled"];
    hidePaidPromotionCard.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hidePaidPromotionCard_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hidePreviousAndNextButton = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_PREVIOUS_AND_NEXT_BUTTON") titleDescription:LOC(@"HIDE_PREVIOUS_AND_NEXT_BUTTON_DESC")];
    hidePreviousAndNextButton.hasSwitch = YES;
    hidePreviousAndNextButton.switchVisible = YES;
    hidePreviousAndNextButton.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hidePreviousAndNextButton_enabled"];
    hidePreviousAndNextButton.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hidePreviousAndNextButton_enabled"];
        return YES;
    };

    YTSettingsSectionItem *ytMiniPlayer = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"YT_MINIPLAYER") titleDescription:LOC(@"YT_MINIPLAYER_DESC")];
    ytMiniPlayer.hasSwitch = YES;
    ytMiniPlayer.switchVisible = YES;
    ytMiniPlayer.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytMiniPlayer_enabled"];
    ytMiniPlayer.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytMiniPlayer_enabled"];
        return YES;
    };

    YTSettingsSectionItem *castConfirm = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"CAST_CONFIRM") titleDescription:LOC(@"CAST_CONFIRM_DESC")];
    castConfirm.hasSwitch = YES;
    castConfirm.switchVisible = YES;
    castConfirm.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"castConfirm_enabled"];
    castConfirm.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"castConfirm_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hideHoverCard = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_HOVER_CARD") titleDescription:LOC(@"HIDE_HOVER_CARD_DESC")];
    hideHoverCard.hasSwitch = YES;
    hideHoverCard.switchVisible = YES;
    hideHoverCard.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideHoverCards_enabled"];
    hideHoverCard.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hideHoverCards_enabled"];
        return YES;
    };

    YTSettingsSectionItem *bigYTMiniPlayer = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"NEW_MINIPLAYER_STYLE") titleDescription:LOC(@"NEW_MINIPLAYER_STYLE_DESC")];
    bigYTMiniPlayer.hasSwitch = YES;
    bigYTMiniPlayer.switchVisible = YES;
    bigYTMiniPlayer.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"bigYTMiniPlayer_enabled"];
    bigYTMiniPlayer.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"bigYTMiniPlayer_enabled"];
        return YES;
    };

    YTSettingsSectionItem *reExplore = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"YT_RE_EXPLORE") titleDescription:LOC(@"YT_RE_EXPLORE_DESC")];
    reExplore.hasSwitch = YES;
    reExplore.switchVisible = YES;
    reExplore.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"reExplore_enabled"];
    reExplore.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"reExplore_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hideCC = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_SUBTITLES_BUTTON") titleDescription:LOC(@"HIDE_SUBTITLES_BUTTON_DESC")];
    hideCC.hasSwitch = YES;
    hideCC.switchVisible = YES;
    hideCC.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideCC_enabled"];
    hideCC.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hideCC_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hideAutoplaySwitch = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_AUTOPLAY_SWITCH") titleDescription:LOC(@"HIDE_AUTOPLAY_SWITCH_DESC")];
    hideAutoplaySwitch.hasSwitch = YES;
    hideAutoplaySwitch.switchVisible = YES;
    hideAutoplaySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideAutoplaySwitch_enabled"];
    hideAutoplaySwitch.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hideAutoplaySwitch_enabled"];
        return YES;
    };

    YTSettingsSectionItem *autoFull = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"AUTO_FULLSCREEN") titleDescription:LOC(@"AUTO_FULLSCREEN_DESC")];
    autoFull.hasSwitch = YES;
    autoFull.switchVisible = YES;
    autoFull.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoFull_enabled"];
    autoFull.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"autoFull_enabled"];
        return YES;
    };

    YTSettingsSectionItem *hideHUD = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"HIDE_HUD_MESSAGES") titleDescription:LOC(@"HIDE_HUD_MESSAGES_DESC")];
    hideHUD.hasSwitch = YES;
    hideHUD.switchVisible = YES;
    hideHUD.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideHUD_enabled"];
    hideHUD.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"hideHUD_enabled"];
        return YES;
    };

    YTSettingsSectionItem *oledDarkMode = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"OLED_DARKMODE") titleDescription:LOC(@"OLED_DARKMODE_DESC")];
    oledDarkMode.hasSwitch = YES;
    oledDarkMode.switchVisible = YES;
    oledDarkMode.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"oled_enabled"];
    oledDarkMode.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"oled_enabled"];
        return YES;
    };

    YTSettingsSectionItem *oledKeyBoard = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"OLED_KEYBOARD") titleDescription:LOC(@"OLED_KEYBOARD_DESC")];
    oledKeyBoard.hasSwitch = YES;
    oledKeyBoard.switchVisible = YES;
    oledKeyBoard.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"oledKeyBoard_enabled"];
    oledKeyBoard.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"oledKeyBoard_enabled"];
        return YES;
    };

    NSMutableArray <YTSettingsSectionItem *> *sectionItems = [NSMutableArray arrayWithArray:@[autoFull, castConfirm, ytMiniPlayer, hideAutoplaySwitch, hideCC, hideHUD, hidePaidPromotionCard, hidePreviousAndNextButton, hideHoverCard, bigYTMiniPlayer, oledDarkMode, oledKeyBoard, reExplore, ytDisableHighContrastIcons, ytOldIconStyle, ytNotificationFix, BlueIcons, RedIcons, OrangeIcons, PinkIcons, PurpleIcons, GreenIcons]];
    [delegate setSectionItems:sectionItems forCategory:uYouPlusSection title:@"uYouPlus" titleDescription:nil headerHidden:NO];
}

- (void)updateSectionForCategory:(NSUInteger)category withEntry:(id)entry {
    if (category == uYouPlusSection) {
        [self updateuYouPlusSectionWithEntry:entry];
        return;
    }
    %orig;
}
%end
