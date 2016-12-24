//
//  GlobalObject.h
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalObject : NSObject

+ (GlobalObject *)sharedInstance;

@property (nonatomic, assign) NSString *userNO;
@property (nonatomic, assign) NSString *userID;
@property (nonatomic, assign) NSString *userNick;
@property (nonatomic, assign) NSString *sessionId;
@property (nonatomic, assign) NSUInteger msample_idx;

@end
