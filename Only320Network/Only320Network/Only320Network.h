//
//  Only320Network.h
//  Only320Network
//
//  Created by he baochen on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import "TTURLRequestCachePolicy.h"
#import "TTErrorCodes.h"

// - Requests

#import "TTRequestLoader.h"
#import "TTURLRequest.h"
#import "TTURLRequestDelegate.h"

// - Responses
#import "TTURLResponse.h"
#import "TTURLDataResponse.h"
#import "TTURLImageResponse.h"

// - Classes
#import "TTUserInfo.h"
#import "TTURLRequestQueue.h"
#import "TTURLCache.h"



#define TT_DEFAULT_CACHE_INVALIDATION_AGE (60*60*24)    // 1 day
#define TT_DEFAULT_CACHE_EXPIRATION_AGE   (60*60*24*7)  // 1 week
#define TT_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf

/**
 * Increment the number of active network requests.
 *
 * The status bar activity indicator will be spinning while there are active requests.
 *
 * @threadsafe
 */
void TTNetworkRequestStarted();

/**
 * Decrement the number of active network requests.
 *
 * The status bar activity indicator will be spinning while there are active requests.
 *
 * @threadsafe
 */
void TTNetworkRequestStopped();

///////////////////////////////////////////////////////////////////////////////////////////////////
// Images

#define TTIMAGE(_URL) [[TTURLCache sharedCache] imageForURL:_URL]