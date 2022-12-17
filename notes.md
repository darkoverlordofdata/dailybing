## Notes

### top loop
top loop is a NSURLConnectionDelegate to load ths main json doc from the server.

### detail loop
next level loops through the json data of images and downloads each using another NSURLConnectionDelegate

DBWindow.m - mainwindow
DBDataIndex.m - loads the json, requests 8 DBImageView objects
DBImageView.m - 1 ea download & display the image