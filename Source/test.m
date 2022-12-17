 - (void)startDownloadingURL:sender
{
    // Create a couple requests.
    NSURLRequest *requestOne = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];

    NSURLRequest *requestTwo = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://stackoverflow.com"]
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];

    // Create two download instances
    NSURLDownload *downloadOne = [[NSURLDownload alloc] initWithRequest:requestOne delegate:self];
    NSURLDownload *downloadTwo = [[NSURLDownload alloc] initWithRequest:requestTwo delegate:self];

    if (downloadOne) {
        // Set the destination file.
        [downloadOne setDestination:@"/tmp" allowOverwrite:YES];
    } else {
        // inform the user that the download failed.
    }
    if (downloadTwo) {
        // Set the destination file.
        [downloadTwo setDestination:@"/tmp" allowOverwrite:YES];
    } else {
        // inform the user that the download failed.
    }
}


- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error
{
    // Release the connection.
    [download release];

    // Inform the user.
    NSLog(@"Download failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringErrorKey]);
}

- (void)downloadDidFinish:(NSURLDownload *)download
{
    NSLog(@"The download %@ has finished.", download)

    // Release the download connection.
    [download release];
}