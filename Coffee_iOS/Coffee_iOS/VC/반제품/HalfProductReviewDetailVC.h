//
//  HalfProductReviewDetailVC.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 25..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HalfProductReviewDetailVC : UIViewController{
    NSUserDefaults *defaults;
    
    NSDictionary *dic_result;
    NSDictionary *dic_result3;
    
    NSArray *listArr;
    NSDictionary *dic;
    
    NSMutableArray *title_Arr;
    NSMutableArray *content_Arr;
    NSString        *memo;
}

@property (weak, nonatomic) IBOutlet UITableView *halfDetailTableView;

@property (nonatomic) NSInteger sampleIndex;
// 셀 카운트
@property (nonatomic) NSInteger countNum;
// 버튼 번호 체크(하드코딩)
@property (nonatomic) NSInteger buttonNum;
@property (nonatomic) NSString  *ID;

- (IBAction)closeButton:(id)sender;

@end
