// 
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIKit.h>
#import "DMPhotoTagProtocol.h"

/*
 DMPhotoPagesFactory is an abstract class responsible for creating all kinds
 of controls for a photo pages controller.
 */

@class DMPhotoPagesController;
@class DMShadedView;
@class DMCaptionView;
@class DMPhotoPagesState;
@class DMPhotoViewController;
@class DMTagPopover;
@class DMCommentsView;
@interface DMPhotoPagesFactory : NSObject

- (DMPhotoViewController *)photoViewControllerWithIndex:(NSInteger)index
                                 forPhotoPagesController:(DMPhotoPagesController *)controller;

- (DMShadedView *)upperGradientViewForPhotoPagesController:(DMPhotoPagesController *)controller;
- (DMShadedView *)lowerGradientViewForPhotoPagesController:(DMPhotoPagesController *)controller;

- (DMShadedView *)screenDimmerForPhotoPagesController:(DMPhotoPagesController *)controller;

- (DMTagPopover *)photoPagesController:(DMPhotoPagesController *)controller
                       tagPopoverForTag:(id<DMPhotoTagProtocol>)tag
                         inPhotoAtIndex:(NSInteger)index;

- (DMCommentsView *)photoPagesController:(DMPhotoPagesController *)photoPagesController
       commentsViewForPhotoViewController:(DMPhotoViewController *)photoViewController;

- (Class)commentCellClass;

- (UINib *)commentCellNib;

- (UIToolbar *)upperToolbarForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIToolbar *)lowerToolbarForPhotoPagesController:(DMPhotoPagesController *)controller;
- (NSArray *)upperToolbarItemsForPhotoPagesController:(DMPhotoPagesController *)controller
                                              inState:(DMPhotoPagesState *)state;
- (NSArray *)lowerToolbarItemsForPhotoPagesController:(DMPhotoPagesController *)controller
                                              inState:(DMPhotoPagesState *)state;

- (DMCaptionView *)captionViewForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UILabel *)taggingLabelForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIBarButtonItem *)doneBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)cancelBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)tagBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)doneTaggingBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIAlertController *)photoPagesController:(DMPhotoPagesController *)controller
                   actionSheetForTagPopover:(DMTagPopover *)tagPopover
                             inPhotoAtIndex:(NSInteger)index;
- (UIAlertController *)photoPagesController:(DMPhotoPagesController *)controller
                 actionSheetForPhotoAtIndex:(NSInteger)index;

- (NSString *)actionSheetReportButtonTitle;
- (NSString *)actionSheetDeleteButtonTitle;
- (NSString *)actionSheetCancelButtonTitle;
- (NSString *)actionSheetTagPhotoButtonTitle;

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                      style:(UIBarButtonItemStyle)style
                                     target:(id)aTarget
                                   selector:(SEL)aSelector;

- (UIBarButtonItem *)flexibleSpaceItemForPhotoPagesController:(DMPhotoPagesController *)controller;

- (NSString *)doneBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
- (NSString *)cancelBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
- (NSString *)tagBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
- (NSString *)doneTaggingBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIBarButtonItem *)activityBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)miscBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)commentsExitBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                                count:(NSInteger)numberOfComments;
- (UIBarButtonItem *)hideCommentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIBarButtonItem *)commentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                            count:(NSInteger)numberOfComments;
- (UIBarButtonItem *)toggleTagsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIActivityViewController *)activityViewControllerForPhotoPagesController:(DMPhotoPagesController *)controller
                                                                  withImage:(UIImage *)anImage
                                                                    caption:(NSString*)aCaption;


- (UIImage *)upperToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
                                                   inState:(DMPhotoPagesState *)state;
- (UIImage *)lowerToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
                                                   inState:(DMPhotoPagesState *)state;
- (CGFloat)upperToolbarAlphaForPhotoPagesController:(DMPhotoPagesController *)controller;
- (CGFloat)lowerToolbarAlphaForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIImage *)defaultUpperToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIImage *)defaultLowerToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller;
- (UIImage *)defaulToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller;

- (UIImage *)iconForToggleTagsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                          forState:(UIControlState)state;
- (UIImage *)iconForMiscBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                    forState:(UIControlState)state;
- (UIImage *)iconForCommentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                        forState:(UIControlState)state
                                                       withCount:(NSInteger)count;

@end
