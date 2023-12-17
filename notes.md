## Notes

### todo

where to get user name?

save image meta-data in plist?


### configure GNUstep
```

defaults write NSGlobalDomain GSUseIconManager NO
defaults write NSGlobalDomain GSSuppressAppIcon YES
defaults write NSGlobalDomain GSTheme NesedahRik
defaults write NSGlobalDomain NSMenuInterfaceStyle NSNextStepInterfaceStyle


/usr/GNUstep/Local/Applications/DailyBing.app/Resources/catlock.py "-p" "420420"

root =              /usr/GNUstep/Local/Applications/DailyBing.app/Resources/themes
resourcePath =      /home/darko/Documents/GitHub/dailybing/DailyBing.app

```


### alternate menu
defaults write NSGlobalDomain NSMenuInterfaceStyle NSMacintoshInterfaceStyle
defaults write NSGlobalDomain NSMenuInterfaceStyle NSWindows95InterfaceStyle

defaults write NSGlobalDomain GSTheme NarcissusRik


pkill dde-top-panel;pkill dde-dock;openapp DailyBing --lockscreen --pin 420420;dde-dock & dde-top-panel &

sh /usr/GNUstep/Local/Applications/DailyBing.app/Resources/LockScreen


openapp DailyBing --lockscreen --pin 420420 --dde-top-panel --dde-dock

openapp DailyBing --lockscreen --pin 420420 --Menu --plank

cmake --build DailyBing.app
cmake --build DailyBing.app --target install



--dde-top-panel
--dde-dock
--Menu
--plank
--xfce4-panel

