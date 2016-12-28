//
//  CommonTableView.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 29..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CommonTableView.h"
#import "GlobalHeader.h"
#import "CommonTableViewCell.h"

@implementation CommonTableView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 50)];
        [titleName setBackgroundColor:[UIColor clearColor]];
        titleName.textColor = [UIColor blackColor];
        titleName.textAlignment = NSTextAlignmentCenter;
        titleName.font = [UIFont fontWithName:@"Helvetica" size:30.0];
        [self addSubview:titleName];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH_FRAME, 0.5)];
        
        commonTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH_FRAME, self.frame.size.height - 50) style:UITableViewStylePlain];
        commonTableView.delegate = self;
        commonTableView.dataSource = self;
        commonTableView.backgroundColor = [UIColor clearColor];
        commonTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:commonTableView];
        [commonTableView setEditing:YES];
    }
    return self;
}

#pragma mark -
#pragma mark Table Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CommonTableViewCell"];
    
    if (cell == nil){
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CommonTableViewCell"];
    }

    
    [cell.titleText setText:@"1"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == 3){
        NSLog(@"row : %ld", indexPath.row);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selectRow : %ld", indexPath.row);
    
    [checkRow addObject:[NSNumber numberWithInteger:indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"deselectRow : %ld", indexPath.row);
    
    [checkRow removeObject:[NSNumber numberWithInteger:indexPath.row]];
}

@end
