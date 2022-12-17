//1 - using shared NSURLSession session
NSURLSession *session = [NSURLSession sharedSession];

//2 - defining the resource URL
NSString *urlString = [[NSString alloc] initWithFormat:@"https://metrics.cocoapods.org/api/v1/pods/%@",s];


//3 - creating the data task
NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL initWithString:urlString] 
completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    …
    //4 - handle response
    …
}];

//5 - starting the task
[dataTask resume];