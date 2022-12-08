# dailybing

prototype for selecting the daily bing

## ill behaviour:
NSImageView loads the wrong image i.e. whatever image is loaded first is the only image displayed in all views.

I found this only works correctly when using NSURLConnection+sendSynchronousRequest. I've wrapped these calls with dispatch_async to prevent blocking.

## build
To enable writing to Resources/gallery and Resources/themes, this needs to be install to a user writeable location:
```
cd DailyBing
gmake
gmake install GNUSTEP_INSTALLATION_DOMAIN=USER
```

## todo
Should this be changed? Install to /usr/GNUstep, and then change the folder access to allow user write?

Still using catlock.py, this should be upgraded as well to use Cocoa.