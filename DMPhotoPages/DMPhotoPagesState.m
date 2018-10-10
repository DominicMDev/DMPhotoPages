//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import "DMPhotoPagesState.h"
#import "DMPhotoPagesController.h"
#import "DMTagPopover.h"
#import "DMPhotoView.h"
#import "DMPhotoViewController.h"
#import "DMPhotoPagesFactory.h"

@implementation DMPhotoPagesState

#pragma mark - Transitions

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
       willTransitionToState:(DMPhotoPagesState *)nextState{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
  didTransitionToPageAtIndex:(NSInteger)pageIndex{};

#pragma mark - Button Hooks

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectDoneButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
       didSelectCancelButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
       didSelectTagButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
     didSelectActivityButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectMiscButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
     didSelectCommentsButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
   didSelectToggleTagsButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
  didSelectPostCommentButton:(id)sender{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectTagPopover:(DMTagPopover *)tagPopover
              inPhotoAtIndex:(NSInteger)index{}

#pragma mark - Events

- (void)photoPagesControllerDidFinishLoadingView:(DMPhotoPagesController *)controller{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
 didTouchPhotoViewController:(DMPhotoViewController *)photoViewController
           atNormalizedPoint:(CGPoint)normalizedTouchPoint{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveSingleTap:(UITapGestureRecognizer *)singleTapGesture
            withNotification:(NSNotification *)aNotification{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveDoubleTap:(UITapGestureRecognizer *)doubleTapGesture
            withNotification:(NSNotification *)aNotification{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveLongPress:(UILongPressGestureRecognizer *)longPressGesture
            withNotification:(NSNotification *)aNotification{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
          didFinishAddingTag:(DMTagPopover *)tagPopover
            forPhotoAtIndex:(NSInteger)index{}

- (void)photoPagesController:(DMPhotoPagesController *)controller
          textFieldDidReturn:(UITextField *)textField{}

#pragma mark - Rotation

- (BOOL)shouldAutorotatePhotoPagesController:(DMPhotoPagesController *)controller
{
    return YES;
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateUninitialized
@implementation DMPhotoPagesStateUninitialized

- (void)photoPagesControllerDidFinishLoadingView:(DMPhotoPagesController *)controller
{
    [controller enterBrowsingMode];
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateBrowsing
@implementation DMPhotoPagesStateBrowsing


- (void)photoPagesController:(DMPhotoPagesController *)controller
       willTransitionToState:(DMPhotoPagesState *)nextState
{
    
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectMiscButton:(id)sender
{
    NSInteger photoIndex = [controller currentPhotoIndex];
    [controller showActionSheetForPhotoAtIndex:photoIndex];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
     didSelectCommentsButton:(id)sender
{
    [controller enterCommentsMode];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectDoneButton:(id)sender
{
    [controller dismiss];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
          didSelectTagButton:(id)sender
{
    [controller enterTaggingMode];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
 didTouchPhotoViewController:(DMPhotoViewController *)photoViewController
           atNormalizedPoint:(CGPoint)normalizedTouchPoint
{
    [photoViewController.photoView bouncePhoto];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveLongPress:(UILongPressGestureRecognizer *)longPressGesture
            withNotification:(NSNotification *)aNotification
{
    if(longPressGesture.state == UIGestureRecognizerStateBegan){
        NSNumber *photoIndex = aNotification.userInfo[@"currentPhotoIndex"];
        
        if([controller.photosDataSource respondsToSelector:@selector(photoPagesController:didReceiveLongPress:forPhotoAtIndex:)])
        {
            [controller.photosDataSource photoPagesController:controller
                                          didReceiveLongPress:longPressGesture
                                              forPhotoAtIndex:[photoIndex integerValue]];
            
        } else {
            [controller showActionSheetForPhotoAtIndex:[photoIndex integerValue]];
        }
    }
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveSingleTap:(UITapGestureRecognizer *)singleTapGesture
            withNotification:(NSNotification *)aNotification
{
    [controller enterBrowsingModeWithInterfaceHidden];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveDoubleTap:(UITapGestureRecognizer *)doubleTapGesture
            withNotification:(NSNotification *)aNotification
{
    if([aNotification.object isKindOfClass:[DMPhotoView class]]){
        DMPhotoView *photoView = aNotification.object;
        [photoView zoomToPoint:[doubleTapGesture locationInView:photoView]];
    }
}

- (void)photoPagesController:(DMPhotoPagesController *)controller didSelectActivityButton:(id)sender
{
    DMPhotoViewController *photoViewController = [controller currentPhotoViewController];
    id senderItem = nil;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        senderItem = sender;
    }
    [controller presentActivitiesForPhotoViewController:photoViewController fromBarButtonItem:senderItem];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
   didSelectToggleTagsButton:(id)sender
{
    [controller setTagsHidden:!controller.tagsHidden];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectTagPopover:(DMTagPopover *)tagPopover
              inPhotoAtIndex:(NSInteger)index
{
    if([controller.photosDataSource respondsToSelector:@selector(photoPagesController:didSelectTagPopover:inPhotoAtIndex:)]){
        
        [controller.photosDataSource photoPagesController:controller
                                      didSelectTagPopover:tagPopover
                                           inPhotoAtIndex:index];
    } else {
        [controller showActionSheetForTagPopover:tagPopover inPhotoAtIndex:index];
    }
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateBrowsingInterfaceHidden
@implementation DMPhotoPagesStateBrowsingInterfaceHidden

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState
{
    [controller setInterfaceHidden:YES];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
       willTransitionToState:(DMPhotoPagesState *)nextState
{
    [controller setInterfaceHidden:NO];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
         didReceiveSingleTap:(UITapGestureRecognizer *)singleTapGesture
            withNotification:(NSNotification *)aNotification
{
    [controller enterBrowsingMode];
}


@end


#pragma mark -
#pragma mark - DMPhotoPagesStateTaggingNew
@implementation DMPhotoPagesStateTaggingNew


- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState
{
    [controller setCaptionAlpha:0];
    [controller setLowerBarAlpha:0];
    [controller setTaggingLabelHidden:YES];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller willTransitionToState:(DMPhotoPagesState *)nextState
{
    
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
          didFinishAddingTag:(DMTagPopover *)tagPopover
             forPhotoAtIndex:(NSInteger)index
{
    id<DMPhotoPagesDataSource> datasource = controller.photosDataSource;
    if([datasource respondsToSelector:@selector(photoPagesController:
                                                             didAddNewTagAtPoint:
                                                             withText:
                                                             forPhotoAtIndex:
                                                             tagInfo:)]){
        
        [datasource  photoPagesController:controller
                    didAddNewTagAtPoint:tagPopover.normalizedArrowPoint
                               withText:tagPopover.text
                        forPhotoAtIndex:index
                                tagInfo:nil];
    }
    
    //[tagPopover removeFromSuperview];
    [controller enterTaggingMode];
}


- (void)photoPagesController:(DMPhotoPagesController *)controller
       didSelectCancelButton:(id)sender
{
    [controller cancelCurrentTagging];
    [controller enterTaggingMode];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller didTransitionToPageAtIndex:(NSInteger)pageIndex
{
    [controller cancelCurrentTagging];
    [controller enterBrowsingMode];
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateTaggingIdle
@implementation DMPhotoPagesStateTaggingIdle

- (void)photoPagesController:(DMPhotoPagesController *)controller
 didTouchPhotoViewController:(DMPhotoViewController *)photoViewController
        atNormalizedPoint:(CGPoint)normalizedTouchPoint
{
    BOOL taggingIsAllowed = [controller.photosDataSource respondsToSelector:
                         @selector(photoPagesController:shouldAllowTaggingForPhotoAtIndex:)] ?
    [controller.photosDataSource photoPagesController:controller
                    shouldAllowTaggingForPhotoAtIndex:photoViewController.photoIndex] : YES;
    
    if(taggingIsAllowed &&
       [photoViewController.photoView canTagPhotoAtNormalizedPoint:normalizedTouchPoint]){
        [controller enterTagEntryMode];
        [photoViewController tagPhotoAtNormalizedPoint:normalizedTouchPoint];
    }
    
 
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState
{
    [controller setTagsHidden:NO];
    [controller setCaptionAlpha:0];
    [controller setLowerBarAlpha:0];
    [controller setTaggingLabelHidden:NO];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller willTransitionToState:(DMPhotoPagesState *)nextState
{
    [controller setTaggingLabelHidden:YES];
    [controller setCaptionAlpha:1.0];
    [controller setLowerBarAlpha:1.0];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
         didSelectDoneButton:(id)sender
{
    [controller enterBrowsingMode];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
  didTransitionToPageAtIndex:(NSInteger)pageIndex
{
    [controller enterBrowsingMode];
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateCommentingIdle
@implementation DMPhotoPagesStateCommentingIdle

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState
{
    //[controller setTagsHidden:NO];
    [controller setCaptionAlpha:0];
    [controller setLowerGradientAlpha:0];
    [controller setCommentsHidden:NO];
    //[controller startCommenting];
    
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
       willTransitionToState:(DMPhotoPagesState *)nextState
{
    [controller setCaptionAlpha:1];
    [controller setLowerGradientAlpha:1];
    [controller setCommentsHidden:YES];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
     didSelectCommentsButton:(id)sender
{
    [controller enterBrowsingMode];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller
       didSelectCancelButton:(id)sender
{
    [controller enterBrowsingMode];
}

@end


#pragma mark -
#pragma mark - DMPhotoPagesStateCommentingNew
@implementation DMPhotoPagesStateCommentingNew

- (void)photoPagesController:(DMPhotoPagesController *)controller
      didTransitionFromState:(DMPhotoPagesState *)previousState
{
    [controller setCaptionAlpha:0];
    [controller setLowerGradientAlpha:0];
    [controller setCommentsHidden:NO];
}



- (void)photoPagesController:(DMPhotoPagesController *)controller
       didSelectCancelButton:(id)sender
{
    [controller cancelCommenting];
}

- (void)photoPagesController:(DMPhotoPagesController *)controller didTransitionToPageAtIndex:(NSInteger)pageIndex
{
    [controller cancelCommenting];
}

@end
