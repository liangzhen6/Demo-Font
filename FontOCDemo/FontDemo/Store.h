//
//  Store.h
//  FontDemo
//
//  Created by shenzhenshihua on 2017/6/16.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject

+ (NSString *)returnThePath:(NSString *)str;
+ (BOOL)writeID:(id)object pathString:(NSString *)string;
+ (id)readWithPathString:(NSString *)string;

@end
