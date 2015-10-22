//
//  UMengOnlineParameterManger.h
//  ChangDu
//
//  Created by Reader on 15/6/2.
//
//

#import <Foundation/Foundation.h>

@interface UMengOnlineParameterManger : NSObject

@property(nonatomic, retain) NSString* storeHotURL;
@property(nonatomic, retain) NSString* storeRankURL;
@property(nonatomic, retain) NSString* storeCategoryURL;
@property(nonatomic, retain) NSString* storeSearchURL;
@property(nonatomic, retain) NSString* shelfInitBookURL;
@property(nonatomic, retain) NSString* lastPageCommentURL;
@property(nonatomic, retain) NSString* clientInitURL;
@property(nonatomic, retain) NSString* storeAPIURL;
@property(nonatomic, retain) NSString* storeChatURL;
@property(nonatomic, retain) NSString* fetchURL;
@property(nonatomic, assign) NSInteger version;
@property(nonatomic, assign) NSInteger httpConnectTimeout;
@property(nonatomic, assign) NSInteger webCacheTimeOut;
@property(nonatomic, assign) BOOL bShowByAppSwitch;
@property(nonatomic, assign) NSInteger appCheckVersion;

+ (UMengOnlineParameterManger*)shareManger;
@end
