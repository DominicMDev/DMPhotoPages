// 
//  Created by Eddy Borja.
//  Copyright (c) 2014 Eddy Borja. All rights reserved.
/*
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIKit.h>
#import "DMPhotoPagesDataSource.h"
#import "DMPhotoPagesDelegate.h"
#import "DMPhotoPagesStateDelegate.h"
#import "DMTagPopoverDelegate.h"
#import "DMPhotoViewControllerDelegate.h"

@class DMPhotoViewController;
@class DMPhotoPagesFactory;
@interface DMPhotoPagesController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITextFieldDelegate, UIActionSheetDelegate, DMPhotoViewControllerDelegate>

@property (readonly) NSInteger currentPhotoIndex;

@property (nonatomic, strong) id<DMPhotoPagesStateDelegate> currentState;
@property (weak) id<DMPhotoPagesDelegate> photoPagesDelegate;
@property (strong) id<DMPhotoPagesDataSource> photosDataSource;
@property (strong) DMPhotoPagesFactory *photoPagesFactory;

@property (nonatomic, readonly) UIBarButtonItem *doneBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *cancelBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *tagBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *doneTaggingBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *activityBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *miscBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *commentsBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *commentsExitBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *hideCommentsBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *toggleTagsBarButtonItem;


//Set to NO to prevent tags from showing on photos
@property (assign) BOOL tagsHidden;

@property (assign) BOOL commentsHidden;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource photoAtIndex:(NSInteger)index;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource
                delegate:(id<DMPhotoPagesDelegate>)aDelegate;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource
                delegate:(id<DMPhotoPagesDelegate>)aDelegate
            photoAtIndex:(NSInteger)index;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource
       photoPagesFactory:(DMPhotoPagesFactory *)factory;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource
                delegate:(id<DMPhotoPagesDelegate>)aDelegate
       photoPagesFactory:(DMPhotoPagesFactory *)factory;

- (id)initWithDataSource:(id<DMPhotoPagesDataSource>)dataSource
                delegate:(id<DMPhotoPagesDelegate>)aDelegate
       photoPagesFactory:(DMPhotoPagesFactory *)factory
            photoAtIndex:(NSInteger)index;

- (void)dismiss;

- (void)setInterfaceHidden:(BOOL)hidden; //private
- (void)setUpperBarAlpha:(CGFloat)alpha;
- (void)setCaptionAlpha:(CGFloat)alpha;
- (void)setCommentsTableViewAlpha:(CGFloat)alpha;
- (void)setLowerBarAlpha:(CGFloat)alpha;
- (void)setLowerGradientAlpha:(CGFloat)alpha;
- (void)setLowerToolbarBackgroundForState:(DMPhotoPagesState *)state; //private
- (void)setUpperToolbarBackgroundForState:(DMPhotoPagesState *)state; //private
- (void)setTaggingLabelHidden:(BOOL)hidden;
- (void)setComments:(NSArray *)comments forPhotoAtIndex:(NSInteger)index;

- (DMPhotoViewController *)currentPhotoViewController;

- (void)enterBrowsingMode;
- (void)enterBrowsingModeWithInterfaceHidden;
- (void)enterTaggingMode; 
- (void)enterTagEntryMode;
- (void)enterCommentsMode;

- (void)setUpperToolbarItems:(NSArray *)items;
- (void)setLowerToolbarItems:(NSArray *)items;

- (void)updateTagsToggleButton;

- (void)showActionSheetForPhotoAtIndex:(NSInteger)index;

- (void)showActionSheetForTagPopover:(DMTagPopover *)tagPopover inPhotoAtIndex:(NSInteger)index;

- (void)tagPopoverActionSheetClickedDeleteAction:(UIAlertAction *)action;
- (void)tagPopoverActionSheetClickedEditAction:(UIAlertAction *)action;
- (void)tagPopoverActionSheetDidDismiss:(UIAlertAction *)action;
- (void)photoActionSheetClickedAction:(UIAlertAction *)action;

- (void)deletePhotoAtIndex:(NSInteger)index;
- (void)deleteTagPopover:(DMTagPopover *)tagPopover inPhotoAtIndex:(NSInteger)index;

- (void)presentActivitiesForPhotoViewController:(DMPhotoViewController *)photoViewController fromBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)cancelCurrentTagging;

- (void)startCommenting;
- (void)cancelCommenting;



- (void)didSelectActivityButton:(id)sender;
- (void)didSelectMiscButton:(id)sender;
- (void)didSelectCommentsButton:(id)sender;
- (void)didSelectDoneButton:(id)sender;
- (void)didSelectCancelButton:(id)sender;
- (void)didSelectTagButton:(id)sender;
- (void)didSelectTagDoneButton:(id)sender;
- (void)didSelectToggleTagsButton:(id)sender;



@end


