//
//  Header.h
//  YoukuTest
//
//  Created by 黄露洋 on 13-8-16.
//  Copyright (c) 2013年 黄露洋. All rights reserved.
//

#ifndef YoukuTest_Header_h
#define YoukuTest_Header_h

//***************************************************************************************
// imports
#import "AFNetworking.h"
#import "MBHUDView.h"

//***************************************************************************************
// youku
#define kYoukuAppKey @"472cc7c9b8111f50"
#define kYoukuAppScrect @"84fdceb93efe44e95323c7905dfb33c1"
#define kYoukuRedirectUri @"http://u.youku.com/%E6%B4%9E%E5%A6%96%E6%88%91%E6%98%AF%E5%8A%A8%E6%8B%90"
#define kYoukuRedirectUriChinese @"http://u.youku.com/洞妖我是动拐"
#define kYoukuCallbackUrl @"http://i.youku.com/u/id_UMTM2NjEzOTg4"

#define kOAuthCredential @"kOAuthCredential"
#define kOAuthAccessToken @"access_token"
#define kOAuthExpiresIn @"expires_in"
#define kOAuthRefreshToken @"refresh_token"
#define kOAuthTokenType @"token_type"

//***************************************************************************************
// api
#define kApiYoukuBasePath @"https://openapi.youku.com"
#define kApiYoukuTokenPath @"/v2/oauth2/token"
#define kApiYoukuMyVideos @"/v2/videos/by_me.json"
#define kApiYoukuUserVideos @"/v2/videos/by_user.json"
#define kApiYoukuSearcheByKeyword @"v2/searches/video/by_keyword.json"
#define kApiYoukuTVSearcheByKeyword @"v2/searches/show/by_keyword.json"
#define kApiYoukuTVInfoPath @"/v2/searches/show/address_unite.json"

//***************************************************************************************
// segue
#define kSegueShowAuthView @"kSegueShowAuthView"
#define kSegueShowMyVideoList @"kSegueShowMyVideoList"
#define kSegueShowVideoPlayer @"kSegueShowVideoPlayer"
#define kSegueShowSearch @"kSegueShowSearch"
#define kSegueShowUsersVideoList @"kSegueShowUsersVideoList"
#define kSegueShowSearchResult @"kSegueShowSearchResult"
#define kSegueShowTVSearch @"kSegueShowTVSearch"
#define kSegueShowTVSearchResult @"kSegueShowTVSearchResult"
#define kSegueShowTVInfo @"kSegueShowTVInfo"

//***************************************************************************************
// cell identifier
#define kCellIdentifierOtherList @"kCellIdentifierOtherList"
#define kCellIdentifierMyList @"kCellIdentifierMyList"
#define kCellIdentifierSearch @"kCellIdentifierSearch"
#define kCellIdentifierSearchResult @"kCellIdentifierSearchResult"
#define kCellIdentifierTVSearch @"kCellIdentifierTVSearch"
#define kCellIdentifierTVSearchResult @"kCellIdentifierTVSearchResult"
#define kCellIdentifierTVInfo @"kCellIdentifierTVInfo"
#define kCellIdentifierTVSearchResultNull @"kCellIdentifierTVSearchResultNull"

//***************************************************************************************
// marcros
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#endif
