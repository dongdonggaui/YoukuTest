//
//  HLYVideoListBL.m
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-19.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#import "HLYVideoListBL.h"

@implementation HLYVideoListBL

+ (void)getVideoListByUserId:(NSString *)userId
                   onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kApiYoukuBasePath];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    NSDictionary *properties = @{@"user_id": userId,
                                 @"client_id": kYoukuAppKey};
    [client getPath:kApiYoukuUserVideos parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

+ (void)getVideoListByKeyword:(NSString *)keyword
                    onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self getVideoListByKeyword:keyword page:1 onSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
        
    } onFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

+ (void)getVideoListByKeyword:(NSString *)keyword
                         page:(int)page
                    onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kApiYoukuBasePath];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    NSDictionary *properties = @{@"keyword": keyword,
                                 @"client_id": kYoukuAppKey,
                                 @"page": [NSNumber numberWithInt:page]};
    
    [client getPath:kApiYoukuSearcheByKeyword parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

+ (void)getTVListByKeyword:(NSString *)keyword
                      page:(int)page
                 onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kApiYoukuBasePath];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    NSDictionary *properties = @{@"keyword": keyword,
                                 @"client_id": kYoukuAppKey,
                                 @"page": [NSNumber numberWithInt:page]};
    
    [client getPath:kApiYoukuTVSearcheByKeyword parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

+ (void)getTVInfoByTVID:(NSString *)tvid
              onSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              onFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:kApiYoukuBasePath];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
    NSDictionary *properties = @{@"progammeId": tvid,
                                 @"client_id": kYoukuAppKey,
                                 @"type": @"1",
                                 @"source_site": @"14"};
    
    [client getPath:kApiYoukuTVInfoPath parameters:properties success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

@end
