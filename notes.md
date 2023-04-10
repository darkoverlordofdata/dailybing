## Notes

### todo

where to get user name?

save image meta-data in plist?

### new design

1 program does both - download images & lock screen

DailyBing
DailyBing --schedule --at 03:01
DailyBing --lockscreen --pin 123456

where --lockscreen is nonfunctional, use CatLock.py



defaults write NSGlobalDomain GSUseIconManager NO
defaults write NSGlobalDomain GSSuppressAppIcon YES
defaults write NSGlobalDomain GSTheme NesedahRik

defaults write NSGlobalDomain NSMenuInterfaceStyle NSNextStepInterfaceStyle
defaults write NSGlobalDomain NSMenuInterfaceStyle NSMacintoshInterfaceStyle
defaults write NSGlobalDomain NSMenuInterfaceStyle NSWindows95InterfaceStyle


/usr/GNUstep/Local/Applications/DailyBing.app/Resources/catlock.py "-p" "420420"