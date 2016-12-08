//
//  GlobalObject.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2016. 12. 8..
//  Copyright © 2016년 JC1_Joseph. All rights reserved.
//

#import "GlobalObject.h"

@implementation GlobalObject

+ (GlobalObject *)sharedInstance
{
    static GlobalObject *sharedInstance;
    
    @synchronized(self) {
        if(!sharedInstance) {
            sharedInstance = [[GlobalObject alloc] init];
        }
    }
    
    return sharedInstance;
}

- (id)init
{
    NSLog(@"%s", __FUNCTION__);
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

@end
