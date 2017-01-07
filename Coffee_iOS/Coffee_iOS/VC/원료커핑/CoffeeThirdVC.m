//
//  CoffeeThirdVC.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "CoffeeThirdVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface CoffeeThirdVC ()

@end

@implementation CoffeeThirdVC

@synthesize coffeeThirdScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mPosition = 0;
    [self Step1];       //통신 1 구간
}
- (void)Step1{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&session_idx=%@", SAMPLELIST_URL, USER_ID, SESSIONID];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            [defaults synchronize];
            datas = [dic objectForKey:@"datas"];
            NSLog(@"1. DATAS :: %@" , datas);
            [self init:mPosition];
            [self Step2];       //통신 2 구간
            
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
- (void)init:(NSInteger)position{
    //    contentText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
    //
    //    leftText.text = [[datas objectAtIndex:position] valueForKey:@"sample_title"];
    //    NSString *codeStr =[NSString stringWithFormat:@"%@" ,[[datas objectAtIndex:position] valueForKey:@"sample_code"]];
    //    centerText.text = codeStr;
    //    rightText.text = [NSString stringWithFormat:@"(%ld/%@)", position+1 ,total];
    
    //안드로이드
    /*
     mListTv2.setText("(" + mSourceListItems.get(mPosition).getmNum() + "/" + mTotalPosition + ")");
     //                                mListTv1.setText(mSourceListItems.get(mPosition).getmSample_title() +":");
     mListTv1.setText("원료커핑:");
     mListTv3.setText(" " + mSourceListItems.get(mPosition).getmSample_code());
     */
    
    SAMPLE_IDX = [[datas objectAtIndex:position] valueForKey:@"sample_idx"];
    
}

- (void)Step2{
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    //    E/Thread: url  ---->>  http://work.nexall.net/web/app//get_result.php?id=test001&sample_idx=167
    
    NSString *urlString = [NSString stringWithFormat:@"%@?id=%@&sample_idx=%@", REVIEW_URL2, USER_ID, SAMPLE_IDX];
    NSLog(@"SKY URL : %@" , urlString);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if([[dic objectForKey:@"result"] isEqualToString:@"success"]){
            [defaults synchronize];
            NSLog(@"2. DATA :: %@" , dic);
            
            [self init2:dic];
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
- (void)init2:(NSDictionary *)dic{
    //안드로이드
//    String result = resultObject.getString(CommonData.RESULT);
//    String result_message = resultObject.getString(CommonData.RESULT_M);
//    String cup1 = resultObject.getString(CommonData.CUP1);
//    String cup2 = resultObject.getString(CommonData.CUP2);
//    String cup3 = resultObject.getString(CommonData.CUP3);
//    String cup4 = resultObject.getString(CommonData.CUP4);
//    String cup5 = resultObject.getString(CommonData.CUP5);
//    String cup6 = resultObject.getString(CommonData.CUP6);
//    String cup7 = resultObject.getString(CommonData.CUP7);
//    String cup8 = resultObject.getString(CommonData.CUP8);
//    String cup9 = resultObject.getString(CommonData.CUP9);
//    String cup10 = resultObject.getString(CommonData.CUP10);
//    String cup11 = resultObject.getString(CommonData.CUP11);
//    String cup12 = resultObject.getString(CommonData.CUP12);
//    String cup13 = resultObject.getString(CommonData.CUP13);
//    String cup14 = resultObject.getString(CommonData.CUP14);
//    String cup15 = resultObject.getString(CommonData.CUP15);
//    String note3 = resultObject.getString(CommonData.NOTE3);
//    
//    
//    if (result != null) {
//        if (result.trim().equals(commonData.SUCCESS)) {
//            
//            mDetail3Edt.setText(note3);
//            
//            
//            if (cup1.equals("1")) {
//                mDetail3Btn1_1.setImageResource(R.drawable.detail3_iconon);
//                m3Btn1_1 = "1";;
//            } else {
//                mDetail3Btn1_1.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn1_1 = "0";;
//            }
//            
//            if (cup2.equals("1")) {
//                mDetail3Btn1_2.setImageResource(R.drawable.detail3_iconon);
//                m3Btn1_2 = "1";;
//            } else {
//                mDetail3Btn1_2.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn1_2 = "0";;
//            }
//            
//            if (cup3.equals("1")) {
//                mDetail3Btn1_3.setImageResource(R.drawable.detail3_iconon);
//                m3Btn1_3 = "1";;
//            } else {
//                mDetail3Btn1_3.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn1_3 = "0";;
//            }
//            
//            if (cup4.equals("1")) {
//                mDetail3Btn1_4.setImageResource(R.drawable.detail3_iconon);
//                m3Btn1_4 = "1";;
//            } else {
//                mDetail3Btn1_4.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn1_4 = "0";;
//            }
//            
//            if (cup5.equals("1")) {
//                mDetail3Btn1_5.setImageResource(R.drawable.detail3_iconon);
//                m3Btn1_5 = "1";;
//            } else {
//                mDetail3Btn1_5.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn1_5 = "0";;
//            }
//            
//            if (cup6.equals("1")) {
//                mDetail3Btn2_1.setImageResource(R.drawable.detail3_iconon);
//                m3Btn2_1 = "1";;
//            } else {
//                mDetail3Btn2_1.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn2_1 = "0";;
//            }
//            
//            if (cup7.equals("1")) {
//                mDetail3Btn2_2.setImageResource(R.drawable.detail3_iconon);
//                m3Btn2_2 = "1";;
//            } else {
//                mDetail3Btn2_2.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn2_2 = "0";;
//            }
//            
//            
//            if (cup8.equals("1")) {
//                mDetail3Btn2_3.setImageResource(R.drawable.detail3_iconon);
//                m3Btn2_3 = "1";;
//            } else {
//                mDetail3Btn2_3.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn2_3 = "0";;
//            }
//            
//            if (cup9.equals("1")) {
//                mDetail3Btn2_4.setImageResource(R.drawable.detail3_iconon);
//                m3Btn2_4 = "1";;
//            } else {
//                mDetail3Btn2_4.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn2_4 = "0";;
//            }
//            
//            if (cup10.equals("1")) {
//                mDetail3Btn2_5.setImageResource(R.drawable.detail3_iconon);
//                m3Btn2_5 = "1";;
//            } else {
//                mDetail3Btn2_5.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn2_5 = "0";;
//            }
//            
//            if (cup11.equals("1")) {
//                mDetail3Btn3_1.setImageResource(R.drawable.detail3_iconon);
//                m3Btn3_1 = "1";;
//            } else {
//                mDetail3Btn3_1.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn3_1 = "0";;
//            }
//            
//            if (cup12.equals("1")) {
//                mDetail3Btn3_2.setImageResource(R.drawable.detail3_iconon);
//                m3Btn3_2 = "1";;
//            } else {
//                mDetail3Btn3_2.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn3_2 = "0";;
//            }
//            
//            if (cup13.equals("1")) {
//                mDetail3Btn3_3.setImageResource(R.drawable.detail3_iconon);
//                m3Btn3_3 = "1";;
//            } else {
//                mDetail3Btn3_3.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn3_3 = "0";;
//            }
//            
//            if (cup14.equals("1")) {
//                mDetail3Btn3_4.setImageResource(R.drawable.detail3_iconon);
//                m3Btn3_4 = "1";;
//            } else {
//                mDetail3Btn3_4.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn3_4 = "0";;
//            }
//            
//            if (cup15.equals("1")) {
//                mDetail3Btn3_5.setImageResource(R.drawable.detail3_iconon);
//                m3Btn3_5 = "1";;
//            } else {
//                mDetail3Btn3_5.setImageResource(R.drawable.detail3_iconoff);
//                m3Btn3_5 = "0";;
//            }
//            
//            
//        } else {
//            Toast.makeText(SourceDetail3Activity.this, result_message, Toast.LENGTH_SHORT).show();
//        }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [coffeeThirdScrollView setContentSize:CGSizeMake(WIDTH_FRAME, 400)];
}

#pragma mark -
#pragma mark StoryBoard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"coffee4"])
    {
        
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)saveButton:(id)sender {
    
}

- (IBAction)prevButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    [self performSegueWithIdentifier:@"coffee4" sender:sender];
}

- (IBAction)pimaryButton:(id)sender {
}

- (IBAction)secondaryButton:(id)sender {
}



@end
