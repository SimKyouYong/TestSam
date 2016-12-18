//
//  CoffeeFirstVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "SampleVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"


//1. 화면 유아이 잡기
//2. 피커뷰 확인 버튼만 넣어주세영.

@interface SampleVC ()

@end

@implementation SampleVC
@synthesize txt;
@synthesize btn_1;
@synthesize btn_2;
@synthesize btn_3;

@synthesize box;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    box.hidden = YES;
    txt.editable = NO;

    box_position = 0;       //전페이지 테이블뷰 index 값.
    picker_position = 0;    //최초는 첫번째 0
    total = 0;
    //통신 시작
    //http://work.nexall.net/web/app/sample_list.php?id=test001&opt=source&page=1&session_idx=1
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", SAMPLELIST_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        //NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            
            total = [dic objectForKey:@"totalnum"];
            [defaults synchronize];
            datas = [dic objectForKey:@"datas"];
            NSLog(@"SAMPLE_DATA :: %@" , datas);
            [self init:picker_position];
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:[dic objectForKey:@"result_message"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];


}

- (void)init:(int)position{
    
    //텍스트 셋팅
    NSString *str = [[datas objectAtIndex:position] valueForKey:@"sample_content"];
//    self.txt.text = @"abc";
    [txt setText:str];
    NSString * str1 =[[datas objectAtIndex:position] valueForKey:@"sample_title"];
    //[btn_1 setTitle:[NSString stringWithFormat:@"%@:" , str1] forState:UIControlStateNormal];
    btn_1.titleLabel.text = str1;
    btn_1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    NSString * str2 =[NSString stringWithFormat:@"%@" ,[[datas objectAtIndex:position] valueForKey:@"sample_code"]];

    [btn_2 setTitle:str2 forState:UIControlStateNormal];
    [btn_3 setTitle:[NSString stringWithFormat:@"(%d/%@)" ,position+1 ,total ] forState:UIControlStateNormal];
    btn_3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    NSLog(@"ccc1:: %@" , [[datas objectAtIndex:position] valueForKey:@"sample_title"]);
    NSLog(@"ccc2:: %@" , [[datas objectAtIndex:position] valueForKey:@"sample_code"]);
    NSLog(@"ccc3:: %@" , [NSString stringWithFormat:@"(%d/%@)" ,position+1 ,total ]);
    NSLog(@"ccc4:: %@" , [[datas objectAtIndex:position] valueForKey:@"sample_content"]);
   
    //피커뷰 셋팅
    //일부러 뷰밖에서 생성한다.
//    Box.delegate = self;
//    Box.dataSource = self;
//    Box.showsSelectionIndicator = YES;
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    Box.transform = CGAffineTransformMakeTranslation(0, -275); //위로 쭈욱하고 올라온다.
//    [UIView commitAnimations];
//    //[self pickerView:pickerview didSelectRow:4 inComponent:0];//자동으로 처음값을 설정
//    
//    //집어넣을땐
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    Box.transform = CGAffineTransformMakeTranslation(0, 275); //그냥 아래로 다시 내려주자
//    [UIView commitAnimations];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"coffee2"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)homeButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//피커뷰 확인 눌럿을떼 , datas 어레이로 다시 값 뿌리면 끝!
- (IBAction)slectChoiceButton:(id)sender {
    //피커뷰 생성
    //box.hidden = NO;
    //[self init:picker_position];
}

#pragma mark -
#pragma PickerView

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return (NSString*)[[datas objectAtIndex:box_position] valueForKey:@"num"];
}

//컴포넌트의 개수 - 데이트피커를 떠올려보라. 시간,분,초등이 있지않는가? 바로 그 항목의 수이다.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//데이터의 개수
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"cout : %lu" ,(unsigned long)[datas count] );
    return [datas count] ;
}


//피커뷰의 가로사이즈를 설정하는것
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}

//피커의 값이 변경되면 호출되는 함수
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%ld",(long)row);
    picker_position = (int)row;
}

@end
