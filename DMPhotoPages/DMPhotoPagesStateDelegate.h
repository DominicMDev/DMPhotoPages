//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
//
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import <UIKit/UIKit.h>

@class DMPhotoPagesController;
@class DMTagPopover;
@class DMPhotoPagesState;
@class DMPhotoView;
@class DMPhotoViewController;
@protocol DMPhotoPagesStateDelegate <NSObject>

#pragma mark - Transitions

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState;

- (void)photoPagesController:(DMPhotoPagesController *)controller
     willTransitionToState:(DMPhotoPagesState *)nextState;

- (void)photoPagesController:(DMPhotoPagesController *)controller
  didTransitionToPageAtIndex:(NSInteger)pageIndex;

#pragma mark - Button Hooks


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectDoneButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectCancelButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
            didSelectTagButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectActivityButton:(id)sender;


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectMiscButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectCommentsButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
   didSelectToggleTagsButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
  didSelectPostCommentButton:(id)sender;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectTagPopover:(DMTagPopover *)tagPopover
              inPhotoAtIndex:(NSInteger)index;

#pragma mark - Events

- (void)photoPagesControllerDidFinishLoadingView:(DMPhotoPagesController *)controller;

- (void)photoPagesController:(DMPhotoPagesController *)controller
 didTouchPhotoViewController:(DMPhotoViewController *)photoViewController
           atNormalizedPoint:(CGPoint)normalizedTouchPoint;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveSingleTap:(UITapGestureRecognizer *)singleTapGesture
            withNotification:(NSNotification *)aNotification;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveDoubleTap:(UITapGestureRecognizer *)doubleTapGesture
            withNotification:(NSNotification *)aNotification;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveLongPress:(UILongPressGestureRecognizer *)longPressGesture
            withNotification:(NSNotification *)aNotification;

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didFinishAddingTag:(DMTagPopover *)tagPopover
            forPhotoAtIndex:(NSInteger)index;

- (void)photoPagesController:(DMPhotoPagesController *)controller
          textFieldDidReturn:(UITextField *)textField;

#pragma mark - Rotation

- (BOOL)shouldAutorotatePhotoPagesController:(DMPhotoPagesController *)controller;

@end
