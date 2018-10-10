//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import "DMPhotoPagesStateDelegate.h"

@class DMCommentCell;
@class DMPhotoComment;
@class DMPhotoPagesController;
@protocol DMPhotoPagesDelegate <NSObject>
@optional

//Return NO to prevent the controller from transitioning to nextState. The controller will stay in currentState unless you explictly set it to a new state.
- (BOOL)photoPagesController:(DMPhotoPagesController *)controller
    shouldTransitionfromCurrentState:(id<DMPhotoPagesStateDelegate>)currentState
                          toNewState:(id<DMPhotoPagesStateDelegate>)nextState;


// Return NO to prevent the controller from configuring a comment cell on it's own.
// You should handle the configuration of cell yourself if you return NO.
- (BOOL)photoPagesController:(DMPhotoPagesController *)controller
  shouldConfigureCommentCell:(DMCommentCell *)cell
           forRowAtIndexPath:(NSIndexPath *)path
                 withComment:(id<DMPhotoCommentProtocol>)comment;


//Return NO to cancel dismissal of the photoPagesController, for example, so you can handle
//its dismiss animation on your own. 
- (BOOL)shouldDismissPhotoPagesController:(DMPhotoPagesController *)photoPagesController;

//Called when a photo pages controller is about to dismiss
- (void)photoPagesControllerWillDismiss:(DMPhotoPagesController *)photoPagesController;

//Called once the photo pages controller has dismissed
- (void)photoPagesControllerDidDismiss:(DMPhotoPagesController *)photoPagesController;




@end
