//
//  PopupListView.h
//
//  Created by Luka Penger on 27/03/14.
//  Copyright (c) 2014 Luka Penger. All rights reserved.
//

// This code is distributed under the terms and conditions of the MIT license.
//
// Copyright (c) 2014 Luka Penger
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "PopupListViewCell.h"

@protocol PopupListViewDelegate;

@interface PopupListViewCoffee : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <PopupListViewDelegate> delegate;
@property (nonatomic, strong) NSMutableIndexSet *selectedIndexes;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *buttonLineView;
@property (nonatomic, strong) UIView *buttonLineCenterView;
@property (nonatomic, strong) UIView *navigationBarView;
@property (nonatomic, strong) UIView *separatorLineView;
@property (nonatomic, assign) BOOL closeAnimated;
@property (nonatomic, strong) UIColor *cellHighlightColor;

- (id)initWithTitle:(NSString *)title list:(NSArray *)list selectedIndexes:(NSIndexSet *)selectedList point:(CGPoint)point size:(CGSize)size multipleSelection:(BOOL)multipleSelection disableBackgroundInteraction:(BOOL)diableInteraction dataName:(NSString*)dataName;
- (void)showInView:(UIView *)view animated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;

@end

#pragma mark -
#pragma mark Delegate Protocol

@protocol PopupListViewDelegate <NSObject>

@optional
- (void)popupListViewCancel;
- (void)popupListView:(PopupListViewCoffee *)popupListView didSelectIndex:(NSInteger)index;
- (void)popupListViewDidHide:(PopupListViewCoffee *)popupListView selectedIndexes:(NSIndexSet *)selectedIndexes dataNameStr:(NSString*)dataNameStr;
@end
