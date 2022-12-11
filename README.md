# dailybing

prototype for selecting the daily bing

## ill behaviour:
NSImageView loads the wrong image i.e. whatever image is loaded first is the only image displayed in all views.

I found this only works correctly when using NSURLConnection+sendSynchronousRequest. I've wrapped these calls with dispatch_async to prevent blocking.

## build
To enable writing to Resources/gallery and Resources/themes, this needs to be install to a user writeable location ($HOME/GNUstep/Applications/DailyBing.app):
/home/darko/GNUstep/Applications/DailyBing.app/Resources/catlock.py --pin 420420
```
cd DailyBing
gmake
gmake install GNUSTEP_INSTALLATION_DOMAIN=USER
```

## todo
Prefer loading locally cached image.
Still using catlock.py, this should be upgraded as well to use Cocoa.

## testing

openapp /home/darko/GNUstep/Applications/DailyBing.app

running from menu, cwd is /home/darko

I need /home/darko/GNUstep/Applications/DailyBing.app


wallpaper = /home/darko/Documents/GitHub/DailyBing/DailyBing.app/Resources/gallery/FlorenceAerial_EN-US1751882328