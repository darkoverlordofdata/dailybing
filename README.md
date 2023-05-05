# dailybing

prototype for selecting the daily bing

### usage
To run interactively:
```
openapp DailyBing
```
To schedule daily download:
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



