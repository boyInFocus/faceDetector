/*!
 * @file    DLog.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 * Define the log format
 */

//#ifndef UvcTest_DLog_h
//#define UvcTest_DLog_h

// DLog(@"here"); or  DLog(@"value: %d", x);
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

