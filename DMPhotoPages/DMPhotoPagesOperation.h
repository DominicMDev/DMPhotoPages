//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */



#import <Foundation/Foundation.h>
#import "DMPhotoPagesDataSource.h"

/*DMPhotoPagesOperation is an NSOperation subclass that is further subclassed into individual load
 operations for different kinds of data related to a photo*/

@class DMPhotoPagesController;
@class DMPhotoViewController;
@interface DMPhotoPagesOperation : NSOperation

@property (assign) __block BOOL loadingFinished;
@property (strong) NSObject<DMPhotoPagesDataSource> *dataSource;
@property (strong) DMPhotoViewController *photoViewController;
@property (strong) DMPhotoPagesController *photoPagesController;

- (id)initWithPhotoPagesController:(DMPhotoPagesController *)photoPagesController
               photoViewController:(DMPhotoViewController *)photoViewController
                        dataSource:(id<DMPhotoPagesDataSource>)dataSource;
@end

//DMImageLoadOperation handles the retrieval of a UIImage for a photo
@interface DMImageLoadOperation : DMPhotoPagesOperation
@end

//DMCaptionLoadOperation handles the retrieval of a text caption for a photo
@interface DMCaptionLoadOperation : DMPhotoPagesOperation
@end

//DMMetaDataLoadOperation handles the retrieval of any other meta data for a photo
@interface DMMetaDataLoadOperation : DMPhotoPagesOperation
@end

//DMTagsLoadOperation handles the loading of tags
@interface DMTagsLoadOperation :DMPhotoPagesOperation
@end

//DMCommentsLoadOperation handles the loading of comments
@interface DMCommentsLoadOperation : DMPhotoPagesOperation
@end
