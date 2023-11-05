# dailybing

prototype for selecting the daily bing

### usage
To run interactively:
```
openapp DailyBing
```
To schedule daily download (not implemented):
```
openapp DailyBing --schedule --at 03:01
```
To lock screen:
```
openapp DailyBing --lockscreen --pin 123456
```

## build

```
gmake
```

## install
```
sudo -E gmake install
```

or

```
sudo su
./install.sh
exit
```

or

```
gmake install GNUSTEP_INSTALLATION_DOMAIN=USER
```



pkill dde-top-panel;pkill dde-dock;openapp DailyBing --lockscreen --pin 420420;dde-dock & dde-top-panel &

sh /usr/GNUstep/Local/Applications/DailyBing.app/Resources/LockScreen


openapp DailyBing --lockscreen --pin 420420 --task dde-top-panel --task dde-dock