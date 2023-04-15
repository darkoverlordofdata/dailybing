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
make
```

## install
```
sudo -E make install
```

or

```
sudo su
./install.sh
exit
```

or

```
make install GNUSTEP_INSTALLATION_DOMAIN=USER
```


