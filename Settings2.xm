#import "Tweaks/YouTubeHeader/YTSettingsViewController.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItem.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItemManager.h"
#import "Header.h"

@interface YTSettingsSectionItemManager (YouPiP)
- (void)updateYTDHCUISectionWithEntry:(id)entry;
@end

static const NSInteger YTDHCUISection = 101;

extern NSBundle *uYouPlusBundle();
extern BOOL ytDisableHighContrastUI();
extern BOOL RedUI();
extern BOOL BlueUI();
extern BOOL GreenUI();
extern BOOL OrangeUI();
extern BOOL PurpleUI();
extern BOOL PinkUI();

// Settings (YTDHCUISection)
%hook YTAppSettingsPresentationData
+ (NSArray *)settingsCategoryOrder {
    NSArray *order = %orig;
    NSMutableArray *mutableOrder = [order mutableCopy];
    NSUInteger insertIndex = [order indexOfObject:@(1)];
    if (insertIndex != NSNotFound)
        [mutableOrder insertObject:@(YTDHCUISection) atIndex:insertIndex + 1];
    return mutableOrder;
}
%end

%hook YTSettingsSectionItemManager
%new 
- (void)updateYTDHCUISectionWithEntry:(id)entry {
    YTSettingsViewController *delegate = [self valueForKey:@"_dataDelegate"];
    NSBundle *tweakBundle = uYouPlusBundle();

    YTSettingsSectionItem *PinkUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Pink UI" titleDescription:@"Pink UI (have every other ui colors off) App restart is required."];
    PinkUI.hasSwitch = YES;
    PinkUI.switchVisible = YES;
    PinkUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"PinkUI_enabled"];
    PinkUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"PinkUI_enabled"];
        return YES;
    };

    YTSettingsSectionItem *PurpleUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Purple UI" titleDescription:@"Purple UI (have every other ui colors off) App restart is required."];
    PurpleUI.hasSwitch = YES;
    PurpleUI.switchVisible = YES;
    PurpleUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"PurpleUI_enabled"];
    PurpleUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"PurpleUI_enabled"];
        return YES;
    };

    YTSettingsSectionItem *OrangeUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Orange UI" titleDescription:@"Orange UI (have every other ui colors off) App restart is required."];
    OrangeUI.hasSwitch = YES;
    OrangeUI.switchVisible = YES;
    OrangeUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"OrangeUI_enabled"];
    OrangeUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"OrangeUI_enabled"];
        return YES;
    };

    YTSettingsSectionItem *GreenUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Green UI" titleDescription:@"Green UI (have every other ui colors off) App restart is required."];
    GreenUI.hasSwitch = YES;
    GreenUI.switchVisible = YES;
    GreenUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"GreenUI_enabled"];
    GreenUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"GreenUI_enabled"];
        return YES;
    };

    YTSettingsSectionItem *BlueUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"Blue UI") titleDescription:LOC(@"Blue UI (have every other ui colors off) App restart is required.")];
    BlueUI.hasSwitch = YES;
    BlueUI.switchVisible = YES;
    BlueUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"BlueUI_enabled"];
    BlueUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"BlueUI_enabled"];
        return YES;
    };

    YTSettingsSectionItem *RedUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Red UI" titleDescription:@"Red UI (have every other ui colors off) App restart is required."];
    RedUI.hasSwitch = YES;
    RedUI.switchVisible = YES;
    RedUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"RedUI_enabled"];
    RedUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"RedUI_enabled"];
        return YES;
    };
    
    YTSettingsSectionItem *ytDisableHighContrastUI = [[%c(YTSettingsSectionItem) alloc] initWithTitle:@"Revert The High Contrast UI (YTDisableHighContrastUI)" titleDescription:@"App restart is required."];
    ytDisableHighContrastUI.hasSwitch = YES;
    ytDisableHighContrastUI.switchVisible = YES;
    ytDisableHighContrastUI.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"ytDisableHighContrastUI_enabled"];
    ytDisableHighContrastUI.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"ytDisableHighContrastUI_enabled"];
        return YES;
    };

    NSMutableArray <YTSettingsSectionItem *> *sectionItems = [NSMutableArray arrayWithArray:@[ytDisableHighContrastUI, RedUI, BlueUI, GreenUI, OrangeUI, PurpleUI, PinkUI]];
    [delegate setSectionItems:sectionItems forCategory:YTDHCUISection title:@"uYouPlus Personalization" titleDescription:nil headerHidden:NO];
}

- (void)updateSectionForCategory:(NSUInteger)category withEntry:(id)entry {
    if (category == YTDHCUISection) {
        [self updateYTDHCUISectionWithEntry:entry];
        return;
    }
    %orig;
}
%end
