
//***********************************************
//**********      日志输出宏定义      *************
//***********************************************
#ifdef DEBUG
#define LSLog(...) NSLog(__VA_ARGS__)
#else
#define LSLog(...)
#endif
//***********************************************
//***********************************************
//***********************************************

#import "Masonry.h"
//#import "MJExtension.h"
//#import "UIImageView+WebCache.h"

#define IOS7  ([[[[UIDevice currentDevice]systemVersion]substringToIndex:1] doubleValue]>=7)
#define IOS8  ([[[[UIDevice currentDevice]systemVersion]substringToIndex:1] doubleValue]>=8)
#define IOS7_HEIGHT (IOS7 ? 20 : 0)


#define APP_SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_SCREEN_HEIGHT   (APP_SCREEN_BOUNDS.size.height)
#define APP_SCREEN_WIDTH    (APP_SCREEN_BOUNDS.size.width)
#define APP_STATUS_FRAME    [UIApplication sharedApplication].statusBarFrame
#define APP_CONTENT_WIDTH   (APP_SCREEN_BOUNDS.size.width)
#define APP_CONTENT_HEIGHT  (IOS7?(APP_SCREEN_BOUNDS.size.height):(APP_SCREEN_BOUNDS.size.height-APP_STATUS_FRAME.size.height))


//RGB 三个参数数值相同
#define UIColorFromSameRGB(r) [UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:1]
