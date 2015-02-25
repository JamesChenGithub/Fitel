//
//  DebugMarco.h
//  CommonLibrary
//
//  Created by 陈耀武 on 13-10-23.
//  Copyright (c) 2013年 ywchen. All rights reserved.
//

#ifndef CommonLibrary_DebugMarco_h
#define CommonLibrary_DebugMarco_h

// 日志

#define kLogToFile 1

#if kLogToFile

#define DebugLog(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#ifdef DEBUG


#define DebugLog(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define DebugLog(...) /* */
#define NSLog // NSLog


#endif



#endif


#define KenDebug(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define KenDebug(...) /* */

#endif


