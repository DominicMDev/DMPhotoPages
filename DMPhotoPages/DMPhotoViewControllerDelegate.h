//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
//
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */



#import <Foundation/Foundation.h>
#import "DMPhotoTagProtocol.h"
#import "DMPhotoCommentProtocol.h"


@class DMCommentCell;
@class DMPhotoViewController;
@class DMTagPopover;
@class DMCommentsView;
@protocol DMPhotoViewControllerDelegate <NSObject>

- (void)photoViewController:(DMPhotoViewController *)controller
          didPostNewComment:(NSString *)comment;

- (BOOL)photoViewController:(DMPhotoViewController *)controller
           canDeleteComment:(id<DMPhotoCommentProtocol>)comment;

- (void)photoViewController:(DMPhotoViewController *)controller
           didDeleteComment:(id<DMPhotoCommentProtocol>)comment;

- (void)photoViewController:(DMPhotoViewController *)controller
        didSelectTagPopover:(DMTagPopover *)tagPopover;

- (DMTagPopover *)photoViewController:(DMPhotoViewController *)controller
                      tagPopoverForTag:(id<DMPhotoTagProtocol>)tag;

- (DMCommentsView *)commentsViewForPhotoViewController:(DMPhotoViewController *)controller;

- (BOOL)photoViewController:(DMPhotoViewController *)controller
 shouldConfigureCommentCell:(DMCommentCell *)cell
          forRowAtIndexPath:(NSIndexPath *)indexPath
                withComment:(id<DMPhotoCommentProtocol>)comment;


@end
