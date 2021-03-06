//
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import "DMPhotoPagesFactory.h"
#import "DMPhotoPagesController.h"
#import "DMPhotoViewController.h"
#import "DMShadedView.h"
#import "DMCaptionView.h"
#import "DMPhotoPagesState.h"
#import "DMCommentsView.h"
#import "DMPhotoToolbar.h"
#import "DMTagPopover.h"
#import "DMCommentsView.h"
#import "DMCommentsTableView.h"
#import "DMCommentCell.h"
#include <math.h>
//static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation DMPhotoPagesFactory


#pragma mark - Photo Pages Controller

#pragma mark - Photo View Controllers

- (DMPhotoViewController *)photoViewControllerWithIndex:(NSInteger)index
                                 forPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [[DMPhotoViewController alloc] initWithIndex:index delegate:controller];
}

#pragma mark -Toolbars


- (UIToolbar *)upperToolbarForPhotoPagesController:(DMPhotoPagesController *)controller
{
    const CGFloat DefaultToolbarHeight = 44;
    
    CGRect viewFrame = controller.view.frame;
    CGRect toolbarFrame = CGRectMake(0,
                                     0,
                                     viewFrame.size.width,
                                     DefaultToolbarHeight);
    
    UIImage *toolbarBackground = [self
                                  defaultUpperToolbarBackgroundForPhotoPagesController:controller];
    UIToolbar *upperToolbar = [DMPhotoToolbar toolbarWithFrame:toolbarFrame];
    [upperToolbar setTintColor:[self upperToolbarTintColor]];
    [upperToolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [upperToolbar setBackgroundImage:toolbarBackground
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    [upperToolbar setAlpha:[self upperToolbarAlphaForPhotoPagesController:nil]];
    return upperToolbar;
}

- (UIToolbar *)lowerToolbarForPhotoPagesController:(DMPhotoPagesController *)controller
{
    const CGFloat DefaultToolbarHeight = 44;
    
    CGRect viewFrame = controller.view.frame;
    CGRect toolbarFrame = CGRectMake(0,
                                     controller.view.frame.size.height-DefaultToolbarHeight,
                                     viewFrame.size.width,
                                     DefaultToolbarHeight);
    
    
    UIImage *toolbarBackground = [self
                                  defaultUpperToolbarBackgroundForPhotoPagesController:controller];
    UIToolbar *lowerToolbar = [DMPhotoToolbar toolbarWithFrame:toolbarFrame];
    [lowerToolbar setTintColor:[self lowerToolbarTintColor]];
    [lowerToolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin];
    [lowerToolbar setBackgroundImage:toolbarBackground
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    [lowerToolbar setAlpha:[self lowerToolbarAlphaForPhotoPagesController:nil]];
    return lowerToolbar;
}


- (UIImage *)upperToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
                                                   inState:(DMPhotoPagesState *)state
{
    return [self defaultUpperToolbarBackgroundForPhotoPagesController:controller];
}
- (UIImage *)lowerToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
                                                   inState:(DMPhotoPagesState *)state
{
    return [self defaultLowerToolbarBackgroundForPhotoPagesController:controller];
}

- (CGFloat)upperToolbarAlphaForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [self defaultToolbarAlphaForPhotoPagesController:controller];
}

- (CGFloat)lowerToolbarAlphaForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [self defaultToolbarAlphaForPhotoPagesController:controller];
}


- (UIImage *)defaultUpperToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [self defaulToolbarBackgroundForPhotoPagesController:controller];
}

- (UIImage *)defaultLowerToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [self defaulToolbarBackgroundForPhotoPagesController:controller];
}

- (CGFloat)defaultToolbarAlphaForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return 1.0f;
}

- (UIImage *)defaulToolbarBackgroundForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return [UIImage new];
}

#pragma mark - Toolbar Items



- (NSArray *)upperToolbarItemsForPhotoPagesController:(DMPhotoPagesController *)controller
                                              inState:(DMPhotoPagesState *)state
{
    NSArray *items = nil;
    if([state isKindOfClass:[DMPhotoPagesStateBrowsing class]]){
        items = [self upperItemsForBrowsingStateInPhotoPagesController:controller];
    } else if([state isKindOfClass:[DMPhotoPagesStateTaggingIdle class]]){
        items = [self upperItemsForTaggingIdleStateInPhotoPagesController:controller];
    } else if ([state isKindOfClass:[DMPhotoPagesStateTaggingNew class]]){
        items = [self upperItemsForTaggingNewStateInPhotoPagesController:controller];
    } else if ([state isKindOfClass:[DMPhotoPagesStateCommentingNew class]]){
        items = [self upperItemsForCommentingNewStateInPhotoPagesController:controller];
    } else if ([state isKindOfClass:[DMPhotoPagesStateCommentingIdle class]]){
        items = [self upperItemsForCommentingIdleStateInPhotoPagesController:controller];
    }
    
    return items;
}


- (NSArray *)upperItemsForBrowsingStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *upperFlexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *done = [controller doneBarButtonItem];
    NSArray *items = @[upperFlexibleSpace,done];
    return items;
}

- (NSArray *)upperItemsForTaggingIdleStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *flexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *taggingFinish = [controller doneTaggingBarButtonItem];
    NSArray *items = @[flexibleSpace,taggingFinish];
    return items;
}

- (NSArray *)upperItemsForTaggingNewStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *flexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *cancel = [controller cancelBarButtonItem];
    NSArray *items = @[flexibleSpace,cancel];
    return items;
}

- (NSArray *)upperItemsForCommentingNewStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *flexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *cancel = [controller cancelBarButtonItem];
    NSArray *items = @[flexibleSpace,cancel];
    return items;
}

- (NSArray *)upperItemsForCommentingIdleStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *flexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *hideCommentsButton = [controller hideCommentsBarButtonItem];
    NSArray *items = @[flexibleSpace,hideCommentsButton];
    return items;
}

- (NSArray *)lowerToolbarItemsForPhotoPagesController:(DMPhotoPagesController *)controller
                                              inState:(DMPhotoPagesState *)state
{
    NSArray *items = nil;
    if([state isKindOfClass:[DMPhotoPagesStateBrowsing class]]){
        items = [self lowerItemsForBrowsingStateInPhotoPagesController:controller];
    } else if([state isKindOfClass:[DMPhotoPagesStateCommentingIdle class]]){
        items = [self lowerItemsForCommentingIdleStateInPhotoPagesController:controller];
    }
    
    return items;
}

- (NSArray *)lowerItemsForBrowsingStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *lowerFlexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *toggleTagsBarButtonItem = [controller toggleTagsBarButtonItem];
    UIBarButtonItem *activityBarButtonItem = [controller activityBarButtonItem];
    UIBarButtonItem *miscBarButtonItem = [controller miscBarButtonItem];
    UIBarButtonItem *commentsBarButtonItem = [controller commentsBarButtonItem];
    NSArray *items = @[activityBarButtonItem, toggleTagsBarButtonItem, miscBarButtonItem, lowerFlexibleSpace, commentsBarButtonItem, ];
    return items;
}

- (NSArray *)lowerItemsForCommentingIdleStateInPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *lowerFlexibleSpace = [self flexibleSpaceItemForPhotoPagesController:controller];
    UIBarButtonItem *commentsExitBarButtonItem = [controller commentsExitBarButtonItem];
    NSArray *items = @[lowerFlexibleSpace, commentsExitBarButtonItem];
    return items;
}

- (UIBarButtonItem *)flexibleSpaceItemForPhotoPagesController:(DMPhotoPagesController *)controller;
{
    UIBarButtonItem *flexibleSpaceItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                  target:nil
                                                  action:nil];
    return flexibleSpaceItem;
}

- (UIBarButtonItem *)activityBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                             target:controller
                             action:@selector(didSelectActivityButton:)];
    return item;
}

- (UIBarButtonItem *)miscBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIImage *miscImage = [self iconForMiscBarButtonItemForPhotoPagesController:controller
                                              forState:UIControlStateNormal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithImage:miscImage
                             style:UIBarButtonItemStylePlain
                             target:controller
                             action:@selector(didSelectMiscButton:)];
    return item;
}


- (UIBarButtonItem *)commentsExitBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller count:(NSInteger)numberOfComments
{
    UIBarButtonItem *item = [self commentsBarButtonItemForPhotoPagesController:controller withState:UIControlStateSelected count:numberOfComments];
    [item setTintColor:[self photoPagesTintColor]];
    return item;
}

- (UIBarButtonItem *)hideCommentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *hideCommentsTitle = [self hideCommentsBarButtonTitleForPhotoPagesController:controller];
    UIBarButtonItem *hideCommentsButton =[self barButtonItemWithTitle:hideCommentsTitle
                                                                style:UIBarButtonItemStyleDone
                                                               target:controller
                                                             selector:@selector(didSelectCancelButton:)];
    return hideCommentsButton;
}

- (UIBarButtonItem *)commentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller count:(NSInteger)numberOfComments
{
   
    return [self commentsBarButtonItemForPhotoPagesController:controller withState:UIControlStateNormal count:numberOfComments];
}

- (UIBarButtonItem *)commentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller withState:(UIControlState)buttonState count:(NSInteger)numberOfComments
{
    UIImage *commentsImage = [self iconForCommentsBarButtonItemForPhotoPagesController:controller
                                                                              forState:buttonState
                                                                             withCount:numberOfComments];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithImage:commentsImage
                             style:UIBarButtonItemStylePlain
                             target:controller
                             action:@selector(didSelectCommentsButton:)];
    return item;
}


- (UIBarButtonItem *)toggleTagsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    UIControlState buttonState = controller.tagsHidden ? UIControlStateNormal : UIControlStateSelected;
    UIImage *toggleImage =
    [self iconForToggleTagsBarButtonItemForPhotoPagesController:controller
                                                       forState:buttonState];
    UIBarButtonItem *item =
    [[UIBarButtonItem alloc] initWithImage:toggleImage style:UIBarButtonItemStylePlain target:controller action:@selector(didSelectToggleTagsButton:)];
    
    
    return item;
}


- (UIBarButtonItem *)doneBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *doneTitle = [self doneBarButtonTitleForPhotoPagesController:controller];
    UIBarButtonItem *doneButton = [self barButtonItemWithTitle:doneTitle
                                                         style:UIBarButtonItemStyleDone
                                                        target:controller
                                                      selector:@selector(didSelectDoneButton:)];
    return doneButton;
}

- (UIBarButtonItem *)cancelBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *cancelTitle = [self cancelBarButtonTitleForPhotoPagesController:controller];
    UIBarButtonItem *cancelButton =[self barButtonItemWithTitle:cancelTitle
                                                          style:UIBarButtonItemStyleDone
                                                         target:controller
                                                       selector:@selector(didSelectCancelButton:)];
    return cancelButton;
}

- (UIBarButtonItem *)tagBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *tagTitle = [self tagBarButtonTitleForPhotoPagesController:controller];
    UIBarButtonItem *tagButton = [self barButtonItemWithTitle:tagTitle
                                                        style:UIBarButtonItemStylePlain
                                                        target:controller
                                                      selector:@selector(didSelectTagButton:)];
    return tagButton;
}

- (UIBarButtonItem *)doneTaggingBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *doneTaggingTitle = [self doneTaggingBarButtonTitleForPhotoPagesController:controller];
    UIBarButtonItem *doneTaggingButton = [self barButtonItemWithTitle:doneTaggingTitle
                                                                style:UIBarButtonItemStyleDone
                                                               target:controller
                                                             selector:@selector(didSelectTagDoneButton:)];
    return doneTaggingButton;
}

- (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                      style:(UIBarButtonItemStyle)style
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
{
    UIButton *button = [UIButton new];
    [button addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTintColor:[self photoPagesTintColor]];
    
    [button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [self decorateBarButtonCustomView:button barButtonStyle:style];
    [self sizeButtonToFitTitle:button withMinimumSize:[self minimumSizeForBarButtonCustomView]
                                          withPadding:[self paddingForBarButtonCustomViewText]];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [barButton setTintColor:[self photoPagesTintColor]];
    
    
    return barButton;
}

- (void)sizeButtonToFitTitle:(UIButton *)button withMinimumSize:(CGSize)minimumSize withPadding:(CGSize)textPadding
{
    
    //CGSize textSize = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
    
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:
                       @{NSFontAttributeName:button.titleLabel.font}];
    CGRect newFrame = CGRectZero;
    newFrame.size.width = MAX(minimumSize.width,textSize.width+textPadding.width);
    newFrame.size.height = MAX(minimumSize.height,textSize.height+textPadding.height);
    [button setFrame:newFrame];
}

- (void)decorateBarButtonCustomView:(UIView *)customView barButtonStyle:(UIBarButtonItemStyle)style
{
    UIColor *buttonTintColor = [self photoPagesTintColor];
    
    //[customView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15]];

    [customView.layer setCornerRadius:4.0];
    //[customView.layer setBorderColor:[buttonTintColor CGColor]];
    //[customView.layer setBorderWidth:1];
    [customView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [customView.layer setShadowOffset:CGSizeMake(0, 1)];
    [customView.layer setShadowOpacity:1.0];
    [customView.layer setShadowRadius:1];
    
    if([customView isKindOfClass:[UIButton class]]){
        NSString *fontName;
        if(style == UIBarButtonItemStyleDone){
            fontName = [self photoPagesBoldFontName];
        } else {
            fontName = [self photoPagesDefaultFontName];
        }
        
        CGFloat fontSize = 18;
        UIFont *titleLabelFont = [UIFont fontWithName:fontName size:fontSize];
        
        UIButton *button = (UIButton *)customView;
        [button.titleLabel setFont:titleLabelFont];
        [button setTitleColor:buttonTintColor forState:UIControlStateNormal];
        [button setTitleColor:buttonTintColor forState:UIControlStateHighlighted];
    }
}

- (CGSize)minimumSizeForBarButtonCustomView
{
    const CGFloat DefaultMinimumWidth = 50;
    const CGFloat DefaultMinimumHeight = 32;
    return CGSizeMake(DefaultMinimumWidth, DefaultMinimumHeight);
}

- (CGSize)paddingForBarButtonCustomViewText
{
    const CGFloat DefaultWidthPadding = 18;
    const CGFloat DefaultHeightPadding = 0;
    return CGSizeMake(DefaultWidthPadding, DefaultHeightPadding);
}



- (NSString *)doneBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
{
    return NSLocalizedString(@"Done", @"Appears on a button that exits you from a photo browser.");
}

- (NSString *)cancelBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
{
    return NSLocalizedString(@"Cancel", @"Appears on a button that cancels an action in progress.");
}

- (NSString *)hideCommentsBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller
{
    return NSLocalizedString(@"Hide Comments", @"Appears on a button that removes user comments from the screen.");
}

- (NSString *)tagBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
{
    return NSLocalizedString(@"Tag", @"Appears on a button that allows you to tag a photo.");
}

- (NSString *)doneTaggingBarButtonTitleForPhotoPagesController:(DMPhotoPagesController *)controller;
{
    return NSLocalizedString(@"Finish Tagging", @"Appears on a button that exits you from tagging mode in a photo browser.");
}



#pragma mark - Shading
- (DMShadedView *)upperGradientViewForPhotoPagesController:(DMPhotoPagesController *)controller
{
    CGFloat gradientWidth = controller.view.frame.size.width;
    CGFloat gradientHeight = [self defaultGradientHeight];
    CGRect gradientRect = CGRectMake(0,
                                     -55,
                                     gradientWidth,
                                     gradientHeight);
    DMShadedView *upperGradient = [DMShadedView upperGradientWithFrame:gradientRect];
    
    [upperGradient setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
                                       UIViewAutoresizingFlexibleBottomMargin |
                                       UIViewAutoresizingFlexibleHeight];
    return upperGradient;
}

- (DMShadedView *)lowerGradientViewForPhotoPagesController:(DMPhotoPagesController *)controller
{
    CGFloat gradientWidth = controller.view.frame.size.width;
    CGFloat gradientHeight = [self defaultGradientHeight];
    CGRect gradientRect = CGRectMake(0,
                                     (controller.view.frame.size.height - gradientHeight)+1,
                                     gradientWidth,
                                     gradientHeight);
    DMShadedView *lowerGradient = [DMShadedView lowerGradientWithFrame:gradientRect];
    
    [lowerGradient setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleHeight];
    
    return lowerGradient;
}

- (CGFloat)defaultGradientHeight
{
    return 150;
}

- (DMShadedView *)screenDimmerForPhotoPagesController:(DMPhotoPagesController *)controller
{
    DMShadedView *screenDimmer = [DMShadedView screenDimmerWithFrame:controller.view.bounds];
    [screenDimmer setAutoresizingMask:controller.view.autoresizingMask];
    return screenDimmer;
}

#pragma mark - Caption


- (DMCaptionView *)captionViewForPhotoPagesController:(DMPhotoPagesController *)controller
{
    CGRect bounds = controller.view.bounds;
    CGRect frame = CGRectMake(20, 0, bounds.size.width-40, bounds.size.height-44+1);
    DMCaptionView *captionView = [[DMCaptionView alloc] initWithFrame:frame];
    [captionView setContentOffset:CGPointMake(0, -captionView.contentInset.top) animated:NO];
    return captionView;
}


#pragma mark - Action Sheets


- (NSString *)actionSheetCancelButtonTitle
{
    return NSLocalizedString(@"Cancel",
                             @"A title appearing on a button that dismisses an action sheet.");
}

- (NSString *)actionSheetDeleteButtonTitle
{
    return NSLocalizedString(@"Delete Photo",
                             @"A title appearing on a button that deletes a photo.");
}

- (NSString *)actionSheetReportButtonTitle
{
    return NSLocalizedString(@"Report Photo",
                             @"A title appearing on a button that flags a photo as inappropriate.");
}

- (NSString *)actionSheetTagPhotoButtonTitle
{
    return NSLocalizedString(@"Tag Photo",
                             @"A title appearing on a button that lets you tag people in a photo.");
}

- (NSString *)actionSheetDeleteTagButtonTitle
{
    return NSLocalizedString(@"Delete Tag",
                             @"A title appearing on a button that deletes a tag in a photo.");
}

- (NSString *)actionSheetEditTagButtonTitle
{
    return NSLocalizedString(@"Edit Tag",
                             @"A title appearing on a button that edits a tag in a photo.");
}

- (UIAlertController *)photoPagesController:(DMPhotoPagesController *)controller
                   actionSheetForTagPopover:(DMTagPopover *)tagPopover
                             inPhotoAtIndex:(NSInteger)index
{
    NSString *title = [NSString stringWithFormat:@"“%@”", tagPopover.text];
    NSString *cancelTitle = [self actionSheetCancelButtonTitle];
    NSString *deleteTitle = nil;
    NSString *editTitle = nil;
    
    if([controller.photosDataSource respondsToSelector:@selector(photoPagesController:shouldAllowDeleteForTag:inPhotoAtIndex:)])
    {
        if([controller.photosDataSource photoPagesController:controller shouldAllowDeleteForTag:tagPopover inPhotoAtIndex:index]){
            deleteTitle = [self actionSheetDeleteTagButtonTitle];
        }
    }
    
    if([controller.photosDataSource respondsToSelector:@selector(photoPagesController:shouldAllowEditingForTag:inPhotoAtIndex:)])
    {
        if([controller.photosDataSource photoPagesController:controller shouldAllowEditingForTag:tagPopover inPhotoAtIndex:index]){
            editTitle = [self actionSheetEditTagButtonTitle];
        }
    }
    
    if(!editTitle && !deleteTitle){
        return nil;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle: UIAlertControllerStyleActionSheet];
    
    alertController.view.alpha = 0.90f;
    
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil]];
    
    if (deleteTitle) {
        __weak DMPhotoPagesController *weakController = controller;
        [alertController addAction:
        [UIAlertAction actionWithTitle:deleteTitle
                                 style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction * _Nonnull action) {
                                   __strong DMPhotoPagesController *strongController = weakController;
                                   [strongController tagPopoverActionSheetClickedDeleteAction:action];
            
                               }]];
    }
    
    if (editTitle) {
        __weak DMPhotoPagesController *weakController = controller;
        [alertController addAction:
         [UIAlertAction actionWithTitle:editTitle
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * _Nonnull action) {
                                    __strong DMPhotoPagesController *strongController = weakController;
                                    [strongController tagPopoverActionSheetClickedEditAction:action];
                                    
                                }]];
    }
    
    return alertController;
}

- (UIAlertController *)photoPagesController:(DMPhotoPagesController *)controller
                 actionSheetForPhotoAtIndex:(NSInteger)index
{
    BOOL allowTagging = [controller.photosDataSource respondsToSelector:@selector(photoPagesController:shouldAllowTaggingForPhotoAtIndex:)] ?
        [controller.photosDataSource photoPagesController:controller
                        shouldAllowTaggingForPhotoAtIndex:index] : NO;
    
    BOOL allowDelete = [controller.photosDataSource respondsToSelector:@selector(photoPagesController:shouldAllowDeleteForPhotoAtIndex:)] ?
        [controller.photosDataSource photoPagesController:controller
                         shouldAllowDeleteForPhotoAtIndex:index] : NO;
    
    BOOL allowReport = [controller.photosDataSource respondsToSelector:@selector(photoPagesController:shouldAllowReportForPhotoAtIndex:)] ?
    [controller.photosDataSource photoPagesController:controller
                     shouldAllowReportForPhotoAtIndex:index] : NO;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    alertController.view.alpha = 0.90f;
    
    __weak DMPhotoPagesController *weakController = controller;
    
    if (allowTagging) {
        [alertController addAction:
         [UIAlertAction actionWithTitle:[self actionSheetTagPhotoButtonTitle]
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * _Nonnull action) {
                                    __strong DMPhotoPagesController *strongController = weakController;
                                    [strongController photoActionSheetClickedAction:action];
                                    
                                }]];
    }
    
    if (allowReport) {
        [alertController addAction:
         [UIAlertAction actionWithTitle:[self actionSheetReportButtonTitle]
                                  style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * _Nonnull action) {
                                    __strong DMPhotoPagesController *strongController = weakController;
                                    [strongController photoActionSheetClickedAction:action];
                                    
                                }]];
    }
    
    if (allowDelete) {
        [alertController addAction:
         [UIAlertAction actionWithTitle:[self actionSheetDeleteButtonTitle]
                                  style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction * _Nonnull action) {
                                    __strong DMPhotoPagesController *strongController = weakController;
                                    [strongController photoActionSheetClickedAction:action];
                                    
                                }]];
    }
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:[self actionSheetCancelButtonTitle]
                              style:UIAlertActionStyleCancel
                            handler:^(UIAlertAction * _Nonnull action) {
                                __strong DMPhotoPagesController *strongController = weakController;
                                [strongController photoActionSheetClickedAction:action];
                                
                            }]];
    
    return alertController;
}

#pragma mark - Tags



- (DMTagPopover *)photoPagesController:(DMPhotoPagesController *)controller
                       tagPopoverForTag:(id<DMPhotoTagProtocol>)tag
                         inPhotoAtIndex:(NSInteger)index
{
    return [[DMTagPopover alloc] initWithTag:tag];
}

- (UILabel *)taggingLabelForPhotoPagesController:(DMPhotoPagesController *)controller
{
    NSString *fontName = [self photoPagesDefaultFontName];
    UIFont *labelFont = [UIFont fontWithName:fontName size:18];
    NSString *tagModeText = [self taggingLabelString];
    CGSize messageSize = [tagModeText sizeWithAttributes:@{NSFontAttributeName: labelFont}];
    CGRect messageFrame = CGRectMake(0, 0, messageSize.width, messageSize.height);
    UILabel *label = [[UILabel alloc] initWithFrame:messageFrame];
    [label setFont:labelFont];
    [label setText:tagModeText];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setShadowColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [label setShadowOffset:CGSizeMake(0, 1)];
    [label setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|
     UIViewAutoresizingFlexibleTopMargin|
     UIViewAutoresizingFlexibleRightMargin];
    [label setAlpha:0];
    [label setHidden:YES];
    [label setCenter:CGPointMake(controller.view.center.x,
                                 controller.view.frame.size.height*0.92)];
    
    return label;
}

- (NSString *)taggingLabelString
{
    return NSLocalizedString(@"Tap on the photo to create a tag.", @"Instructions for tagging a photo in the photo pages controller.");
}


#pragma mark- Comments


// TODO: Put comment cell identifier in a better place.
- (DMCommentsView *)photoPagesController:(DMPhotoPagesController *)photoPagesController
       commentsViewForPhotoViewController:(DMPhotoViewController *)photoViewController;
{
    CGSize tableViewSize = CGSizeMake(photoViewController.view.frame.size.width,
                                      photoViewController.view.frame.size.height);
    CGRect tableViewFrame = CGRectMake(0,
                                       (photoViewController.view.frame.size.height-tableViewSize.height),
                                       tableViewSize.width,
                                       tableViewSize.height);
    
    DMCommentsView *commentsView = [[DMCommentsView alloc] initWithFrame:tableViewFrame];
    
    [commentsView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
    
    [commentsView.tableView setDataSource:photoViewController];
    [commentsView.tableView setDelegate:photoViewController];
    [commentsView setCommentCellHighlightColor:[self commentCellTintColor]];
    
    static NSString *CellReuseIdentifier= @"Cell";
    UINib *commentCellNib = [self commentCellNib];
    if(commentCellNib){
        [commentsView.tableView registerNib:[self commentCellNib] forCellReuseIdentifier:CellReuseIdentifier];
    } else {
        NSAssert([self commentCellClass],
                 @"If an DMPhotoPagesFactory object doesn't specify a UINib for Comment UITableViewCells it must at least specify a Class to register.");
        [commentsView.tableView registerClass:[self commentCellClass] forCellReuseIdentifier:CellReuseIdentifier];
    }
    [commentsView.commentTextView setDelegate:photoViewController];
    [commentsView setCommentsDelegate:photoViewController];
    
    [commentsView setNeedsLayout];
    
    return commentsView;
}

- (Class)commentCellClass
{
    return [DMCommentCell class];
}

- (UINib *)commentCellNib
{
    return nil;
}





#pragma mark - Activity View Controller


- (UIActivityViewController *)activityViewControllerForPhotoPagesController:(DMPhotoPagesController *)controller
                                                                  withImage:(UIImage *)anImage
                                                                    caption:(NSString*)aCaption
{
    NSMutableArray *data = [NSMutableArray array];
    
    if(anImage){
        [data addObject:anImage];
    }
    
    if(aCaption){
        [data addObject:aCaption];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc]initWithActivityItems:data applicationActivities:nil];
    return activityController;
}



- (UIImage *)iconForToggleTagsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                          forState:(UIControlState)state
{
    CGSize iconSize = CGSizeMake(22, 22);
    CGRect iconFrame = CGRectMake(1, 1, iconSize.width-2, iconSize.height-2);
    
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
    
    CGContextRef composedImageContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(composedImageContext, [[UIColor whiteColor] CGColor]);
    
    CGRect circleRect = CGRectMake(4, 4, 5, 5);
    CGPathRef circle = [[UIBezierPath bezierPathWithOvalInRect:circleRect] CGPath];
    
    CGContextAddPath(composedImageContext, circle);
    
    if(state == UIControlStateSelected){
        CGContextAddRect(composedImageContext, iconFrame);
        CGContextEOClip(composedImageContext);
    } else {
        CGContextSetLineWidth(composedImageContext, 0.75);
        CGContextStrokePath(composedImageContext);
    }
    
    CGMutablePathRef tagPath = CGPathCreateMutable();
    CGPathMoveToPoint(tagPath, NULL, CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame));
    CGPathAddLineToPoint(tagPath, NULL, 10, CGRectGetMinY(iconFrame));
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMaxX(iconFrame), 12);
    CGPathAddLineToPoint(tagPath, NULL, 12, CGRectGetMaxY(iconFrame));
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMinX(iconFrame), 10);
    CGPathAddLineToPoint(tagPath, NULL, CGRectGetMinX(iconFrame), CGRectGetMinY(iconFrame));
    CGContextAddPath(composedImageContext, tagPath);

    if(state == UIControlStateSelected){
        CGContextSetFillColorWithColor(composedImageContext, [[UIColor whiteColor] CGColor]);
        CGContextFillPath(composedImageContext);
    } else {
        CGContextSetLineWidth(composedImageContext, 1);
        CGContextStrokePath(composedImageContext);
    }
    
    CGPathRelease(tagPath);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)iconForMiscBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                 forState:(UIControlState)state
{
    CGFloat diameter = 6;
    CGFloat spacing = 4;
    CGSize iconSize = CGSizeMake(((diameter+spacing)*2)+diameter+2, 25);
    
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
    
    CGContextRef composedImageContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(composedImageContext, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(composedImageContext, [[UIColor whiteColor] CGColor]);
    
    CGFloat y_Origin = (iconSize.height - diameter)*0.5;
    CGFloat x_Origin = 1;
    CGRect circleRect = CGRectMake(x_Origin, y_Origin, diameter, diameter);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    CGContextAddPath(composedImageContext, [circlePath CGPath]);
    
    circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectOffset(circleRect, diameter+spacing, 0)];
    CGContextAddPath(composedImageContext, [circlePath CGPath]);
    
    
    circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectOffset(circleRect, (diameter+spacing)*2, 0)];
    CGContextAddPath(composedImageContext, [circlePath CGPath]);
    
    if(state == UIControlStateSelected){
        CGContextFillPath(composedImageContext);
    } else {
        CGContextStrokePath(composedImageContext);
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)iconForLikesBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                     forState:(UIControlState)state
                                                    withCount:(NSInteger)count
{
    CGSize iconSize = CGSizeMake(27, 30);
    
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    
    CGRect heartRect = CGRectMake(1, 1, iconSize.width-2, iconSize.height-2);
    
    CGFloat minx = CGRectGetMinX(heartRect), midx = CGRectGetMidX(heartRect), maxx = CGRectGetMaxX(heartRect);
    CGFloat miny = CGRectGetMinY(heartRect), midy = CGRectGetMidY(heartRect)-3, maxy = CGRectGetMaxY(heartRect)-3;
    
    // Start at 1
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGFloat centerPlunge = 0.3;
    CGFloat top_Y_Anchor = 0.225;
    CGFloat top_X_Anchor = 0.3;
    CGContextAddCurveToPoint(context,
                             minx, maxy*top_Y_Anchor,
                             maxx*top_X_Anchor, miny,
                             midx, maxy*centerPlunge);
    
    CGContextAddCurveToPoint(context,
                             maxx*(1-top_X_Anchor), miny,
                             maxx, maxy*top_Y_Anchor,
                             maxx, midy);
    
    CGFloat bottom_Y_Anchor = 0.885;
    CGFloat mid_Y_Anchor = 0.66;
    CGContextAddCurveToPoint(context,
                             maxx, maxy*mid_Y_Anchor,
                             maxx*0.8, maxy*bottom_Y_Anchor,
                             midx, maxy);
    
    CGContextAddCurveToPoint(context,
                             maxx*0.2, maxy*bottom_Y_Anchor,
                             minx, maxy*mid_Y_Anchor,
                             minx, midy);

    CGContextClosePath(context);
    
    // Fill & stroke the path
    CGRect countLabelRect = CGRectOffset(heartRect, 0, -1);
    UILabel *countLabel = [[UILabel alloc] initWithFrame:countLabelRect];
    NSString *fontName = [self photoPagesBoldFontName];
    [countLabel setFont:[UIFont fontWithName:fontName size:12]];
    NSString *labelString;
    
    if(count == 0){
        labelString = @"";
    } else if (count > 99) {
        labelString = @"99+";
    } else {
        labelString = [NSString stringWithFormat:@"%li", (long)count];
    }
    
    [countLabel setText:labelString];
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    if(state == UIControlStateSelected){
        CGContextFillPath(context);
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        [countLabel drawTextInRect:countLabelRect];
        CGContextRestoreGState(context);
    } else {
        CGContextStrokePath(context);
        [countLabel drawTextInRect:countLabelRect];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)iconForCommentsBarButtonItemForPhotoPagesController:(DMPhotoPagesController *)controller
                                                        forState:(UIControlState)state
                                                       withCount:(NSInteger)count
{
    CGSize iconSize = CGSizeMake(25, 27);
    
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    
    CGRect bubbleRect = CGRectMake(1, 1+iconSize.height*0.05, iconSize.width-2, (iconSize.height*0.69)-2);
    
    CGFloat minx = CGRectGetMinX(bubbleRect), midx = CGRectGetMidX(bubbleRect), maxx = CGRectGetMaxX(bubbleRect);
    CGFloat miny = CGRectGetMinY(bubbleRect), midy = CGRectGetMidY(bubbleRect), maxy = CGRectGetMaxY(bubbleRect);
    
    CGFloat radius = 3.0;
    // Start at 1
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    
    CGContextAddLineToPoint(context, midx, maxy);
    CGContextAddLineToPoint(context, midx-5, maxy+5);
    CGContextAddLineToPoint(context, midx-5, maxy);
    
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);
    
    // Fill & stroke the path
    CGRect countLabelRect = CGRectOffset(bubbleRect, 0, -1);
    UILabel *countLabel = [[UILabel alloc] initWithFrame:countLabelRect];
    NSString *fontName = [self photoPagesBoldFontName];
    [countLabel setFont:[UIFont fontWithName:fontName size:12]];
    NSString *labelString;
    
    if(count == 0){
        labelString = @"";
    } else if (count > 99) {
        labelString = @"99+";
    } else {
        labelString = [NSString stringWithFormat:@"%li", (long)count];
    }
    
    [countLabel setText:labelString];
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    if(state == UIControlStateSelected){
        CGContextFillPath(context);
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, kCGBlendModeSourceOut);
        [countLabel drawTextInRect:countLabelRect];
        CGContextRestoreGState(context);
    } else {
        CGContextStrokePath(context);
        [countLabel drawTextInRect:countLabelRect];
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Font and Color

- (NSString *)photoPagesDefaultFontName
{
    return @"HelveticaNeue-Light";
}

- (NSString *)photoPagesBoldFontName
{
    return @"HelveticaNeue-Bold";
}

- (UIColor *)upperToolbarTintColor
{
    return [self photoPagesTintColor];
}

- (UIColor *)lowerToolbarTintColor
{
    return [self photoPagesTintColor];
}

- (UIColor *)commentCellTintColor
{
    UIColor *photoPagesColor = [self photoPagesTintColor];
    return [photoPagesColor colorWithAlphaComponent:0.35];
}

- (UIColor *)photoPagesTintColor
{
    return [UIColor colorWithWhite:0.99 alpha:1.0];
}

@end
