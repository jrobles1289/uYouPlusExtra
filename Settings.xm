#import "Tweaks/YouTubeHeader/YTSettingsViewController.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItem.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItemManager.h"
#import "Header.h"

@interface YTSettingsSectionItemManager (YouPiP)
- (void)updateYTPREVIEWSectionWithEntry:(id)entry;
@end

static const NSInteger YTPREVIEWSection = 102;

extern NSBundle *uYouPlusBundle();
extern BOOL oled();
extern BOOL oledKB();

// Settings (YTPREVIEWSection)
%hook YTAppSettingsPresentationData
+ (NSArray *)settingsCategoryOrder {
    NSArray *order = %orig;
    NSMutableArray *mutableOrder = [order mutableCopy];
    NSUInteger insertIndex = [order indexOfObject:@(1)];
    if (insertIndex != NSNotFound)
        [mutableOrder insertObject:@(YTPREVIEWSection) atIndex:insertIndex + 1];
    return mutableOrder;
}
%end

%hook YTSettingsSectionItemManager
%new 
- (void)updateYTPREVIEWSectionWithEntry:(id)entry {
    YTSettingsViewController *delegate = [self valueForKey:@"_dataDelegate"];
    NSBundle *tweakBundle = uYouPlusBundle();
    
    YTSettingsSectionItem *oledKeyBoard = [[%c(YTSettingsSectionItem) alloc] initWithTitle:LOC(@"OLED_KEYBOARD") titleDescription:LOC(@"OLED_KEYBOARD_DESC")];
    oledKeyBoard.hasSwitch = YES;
    oledKeyBoard.switchVisible = YES;
    oledKeyBoard.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"oledKeyBoard_enabled"];
    oledKeyBoard.switchBlock = ^BOOL (YTSettingsCell *cell, BOOL enabled) {
        [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"oledKeyBoard_enabled"];
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

    NSMutableArray <YTSettingsSectionItem *> *sectionItems = [NSMutableArray arrayWithArray:@[oledDarkMode, oledKeyBoard]];
    [delegate setSectionItems:sectionItems forCategory:YTPREVIEWSection title:@"uYouPlus Experimental" titleDescription:nil headerHidden:NO];
}

- (void)updateSectionForCategory:(NSUInteger)category withEntry:(id)entry {
    if (category == YTPREVIEWSection) {
        [self updateYTPREVIEWSectionWithEntry:entry];
        return;
    }
    %orig;
}
%end
