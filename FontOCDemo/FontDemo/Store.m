//
//  Store.m
//  FontDemo
//
//  Created by shenzhenshihua on 2017/6/16.
//  Copyright © 2017年 shenzhenshihua. All rights reserved.
//

#import "Store.h"

@implementation Store

+ (NSString *)returnThePath:(NSString *)str{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:str];
    return path;
    
}
+ (id)readWithPathString:(NSString *)string{
    NSString * path = [Store returnThePath:string];
    NSLog(@"hahah-%@",path);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
}
+ (BOOL)writeID:(id)objects pathString:(NSString *)string{
    
    NSString * path = [Store returnThePath:string];
    
   BOOL isOk =  [NSKeyedArchiver archiveRootObject:objects toFile:path];
    
    return isOk;
}


@end
