//
//  GlobalHeader.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#define WIDTH_FRAME             [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_FRAME            [[UIScreen mainScreen] bounds].size.height

// NSUserDefaults
#define EMP_NUMBER              @"emp_number"
#define PASSWORD                @"password"
#define AUTO_LOGIN              @"auto_login"

// URL
#define LOGIN_URL               @"http://work.nexall.net/web/app/login.php"
#define HOMELIST_URL            @"http://work.nexall.net/web/app/sess_list.php"
#define SAMPLELIST_URL          @"http://work.nexall.net/web/app/sample_list.php"
#define REVIEW_URL              @"http://work.nexall.net/web/app/sample_list.php"
#define REVIEW_URL2             @"http://work.nexall.net/web/app/get_result.php"
#define REVIEW_URL3             @"http://work.nexall.net/web/app/get_avr_result.php"
#define CUPPING_COMMON          @"http://work.nexall.net/web/app/sess_start.php"
#define REVIEW_SAMPLE_URL       @"http://work.nexall.net/web/app/review_list.php"
#define SAMPLE_WEB_URL          @"http://work.nexall.net/creport.php"
#define CUPPING_SAVE            @"http://work.nexall.net/web/app/coffee_result.php"
#define HALF_SAVE               @"http://work.nexall.net/web/app/coffee_result_final.php"

// Memory
#define USER_NO                 [GlobalObject sharedInstance].userNO
#define USER_ID                 [GlobalObject sharedInstance].userID
#define USER_NICK               [GlobalObject sharedInstance].userNick
#define SESSIONID               [GlobalObject sharedInstance].sessionId
#define SAMPLE_IDX              [GlobalObject sharedInstance].sample_idx
#define MPOSITION               [GlobalObject sharedInstance].mPosition

