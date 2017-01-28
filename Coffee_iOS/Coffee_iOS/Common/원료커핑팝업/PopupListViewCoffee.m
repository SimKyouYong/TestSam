//
//  PopupListView.m
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

#import "PopupListViewCoffee.h"
#import "GlobalHeader.h"

#define navigationBarHeight 44.0f
#define separatorLineHeight 1.0f
#define closeButtonWidth 44.0f
#define navigationBarTitlePadding 12.0f
#define animationsDuration 0.25f

@interface PopupListViewCoffee ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayList;
@property (nonatomic, strong) NSString *navigationBarTitle;
@property (nonatomic, strong) NSString *dataNameValue;
@property (nonatomic, assign) BOOL isMultipleSelection;

@end

@implementation PopupListViewCoffee
{
    //Content View
    UIView *contentView;
}

static BOOL isShown = false;

#pragma mark -
#pragma mark Lifecycle

- (id)initWithTitle:(NSString *)title list:(NSArray *)list selectedIndexes:(NSIndexSet *)selectedList point:(CGPoint)point size:(CGSize)size multipleSelection:(BOOL)multipleSelection disableBackgroundInteraction:(BOOL)diableInteraction dataName:(NSString *)dataName{
    self.dataNameValue = dataName;
    
    NSInteger contentHeight = 0;
    if(point.y + 45 + (44 * [list count]) + 40 >= HEIGHT_FRAME){
        contentHeight = 45 + (44 * 4) + 40;
    }else{
        contentHeight = 45 + (44 * [list count]) + 40;
    }
    CGRect contentFrame = CGRectMake(point.x, point.y,size.width, contentHeight);
    
    if (diableInteraction){
        self = [super initWithFrame:[UIScreen mainScreen].bounds];
    }else{
        self = [super initWithFrame:contentFrame];
        contentFrame = CGRectMake(0, 0, size.width, size.height);
    }
    
    if (self){
        //Content View
        contentView = [[UIView alloc] initWithFrame:contentFrame];
        
        //contentView.backgroundColor = [UIColor colorWithRed:(0.0/255.0) green:(108.0/255.0) blue:(192.0/255.0) alpha:0.7];
        contentView.backgroundColor = [UIColor whiteColor];
        
        self.cellHighlightColor = [UIColor colorWithRed:(0.0/255.0) green:(60.0/255.0) blue:(127.0/255.0) alpha:0.5f];
        
        self.navigationBarTitle = title;
        self.arrayList = [NSArray arrayWithArray:list];
        self.selectedIndexes = [[NSMutableIndexSet alloc] initWithIndexSet:selectedList];
        self.isMultipleSelection = multipleSelection;

        self.navigationBarView = [[UIView alloc] init];
        self.navigationBarView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:(0.0/255.0) green:(108.0/255.0) blue:(192.0/255.0) alpha:0.7];
        [contentView addSubview:self.navigationBarView];

        self.separatorLineView = [[UIView alloc] init];
        self.separatorLineView.backgroundColor = [UIColor blueColor];
        [contentView addSubview:self.separatorLineView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = self.navigationBarTitle;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        self.titleLabel.textColor = [UIColor blueColor];
        [self.navigationBarView addSubview:self.titleLabel];
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
        self.tableView.backgroundColor = [UIColor yellowColor];
        [contentView addSubview:self.tableView];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cancelButton setTitle:@"취소" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
        [contentView addSubview:self.cancelButton];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.closeButton setTitle:@"확인" forState:UIControlStateNormal];
        [self.closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
        [contentView addSubview:self.closeButton];
        
        [self addSubview:contentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:contentView.bounds];
    contentView.layer.masksToBounds = NO;
    contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    contentView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    contentView.layer.shadowOpacity = 0.5f;
    contentView.layer.shadowPath = shadowPath.CGPath;
    
    self.navigationBarView.frame = CGRectMake(0.0f, 0.0f, contentView.frame.size.width, navigationBarHeight);
    
    self.separatorLineView.frame = CGRectMake(0.0f, self.navigationBarView.frame.size.height, contentView.frame.size.width, separatorLineHeight);
    
    self.titleLabel.frame = CGRectMake(navigationBarTitlePadding, 0.0f, (self.navigationBarView.frame.size.width-closeButtonWidth-(navigationBarTitlePadding * 2)), navigationBarHeight);
    
    self.tableView.frame = CGRectMake(0.0f, (navigationBarHeight + separatorLineHeight), contentView.frame.size.width, (contentView.frame.size.height-(navigationBarHeight + separatorLineHeight)) - 40);
    
    self.cancelButton.frame = CGRectMake(0, contentView.frame.size.height - 40, self.tableView.frame.size.width/2, 40);
    
    self.closeButton.frame = CGRectMake(self.tableView.frame.size.width/2, contentView.frame.size.height - 40, self.tableView.frame.size.width/2, 40);
}

- (void)cancelButtonClicked:(id)sender
{
    [UIView animateWithDuration:animationsDuration animations:^{
        contentView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        isShown = false;
        
        if (self.isMultipleSelection) {
            [self.delegate popupListViewCancel];
        }
        
        [self removeFromSuperview];
    }];
}

- (void)closeButtonClicked:(id)sender
{
    [self hideAnimated:self.closeAnimated];
}

#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PopupListViewCell";
    
    PopupListViewCell *cell = [[PopupListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.highlightColor = self.cellHighlightColor;
    cell.textLabel.text = [self.arrayList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.isMultipleSelection) {
        if ([self.selectedIndexes containsIndex:indexPath.row]) {
            cell.rightImageView.image = [UIImage imageNamed:@"checkMark"];
        } else {
            cell.rightImageView.image = nil;
        }
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isMultipleSelection) {
        if ([self.selectedIndexes containsIndex:indexPath.row]) {
            [self.selectedIndexes removeIndex:indexPath.row];
        } else {
            [self.selectedIndexes addIndex:indexPath.row];
        }

        [self.tableView reloadData];
    } else {
        isShown = false;
        
        if ([self.delegate respondsToSelector:@selector(popupListView:didSelectIndex:)]) {
            [self.delegate popupListView:self didSelectIndex:indexPath.row];
        }
        
        [self hideAnimated:self.closeAnimated];
    }
}

#pragma mark -
#pragma mark Instance methods

- (void)showInView:(UIView *)view animated:(BOOL)animated
{
    if(!isShown) {
        isShown = true;
        self.closeAnimated = animated;
        
        if(animated) {
            contentView.alpha = 0.0f;
            [view addSubview:self];
            
            [UIView animateWithDuration:animationsDuration animations:^{
                contentView.alpha = 1.0f;
            }];
        } else {
            [view addSubview:self];
        }
    }
}

- (void)hideAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:animationsDuration animations:^{
            contentView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            isShown = false;
            
            if (self.isMultipleSelection) {
                if ([self.delegate respondsToSelector:@selector(popupListViewDidHide:selectedIndexes:dataNameStr:)]) {
                    [self.delegate popupListViewDidHide:self selectedIndexes:self.selectedIndexes dataNameStr:self.dataNameValue];
                }
            }
            
            [self removeFromSuperview];
        }];
    } else {
        isShown = false;
        
        if (self.isMultipleSelection) {
            if ([self.delegate respondsToSelector:@selector(popupListViewDidHide:selectedIndexes:dataNameStr:)]) {
                [self.delegate popupListViewDidHide:self selectedIndexes:self.selectedIndexes dataNameStr:self.dataNameValue];
            }
        }
        
        [self removeFromSuperview];
    }
}

@end
