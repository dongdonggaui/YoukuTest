//
//  HLYVideoListBL.h
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLYVideoListBL : NSObject

+ (void)getVideoListByUserId:(NSString *)userId
                   onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)getVideoListByKeyword:(NSString *)keyword
                    onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)getVideoListByKeyword:(NSString *)keyword
                         page:(int)page
                    onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)getTVListByKeyword:(NSString *)keyword
                      page:(int)page
                 onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
+ (void)getTVInfoByTVID:(NSString *)tvid
              onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
