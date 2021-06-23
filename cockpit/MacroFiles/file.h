//
//  file.h
//  boss
//
//  Created by dzc on 2021/5/10.
//

#ifndef file_h
#define file_h



#ifdef Dev
//测试环境
#define JG_AppKey @"1d1a05054340bce0557d4975"

//#define kMainUrl_HTTP  @"http://test-cockpit.peogoo-inc.com/stage-api"
#define kMainUrl_HTTP  @"http://test-cockpit.peogoo.com:8088/stage-api"
///** 测试升级公告服务器*/
#define kMainUpdateUrl_HTTP @""
///** 测试h5服务器*/
//#define kMainH5Url_HTTP @"http://test-cockpit-h5.peogoo-inc.com/#"
#define kMainH5Url_HTTP @"http://test-cockpit-h5.peogoo.com:8088/#"





#else
//正式环境
#define JG_AppKey @"正式的key"

#define kMainUrl_HTTP  @"http://cockpit.peogoo.com/stage-api/"
/** 正式升级服务器*/
#define kMainUpdateUrl_HTTP @""
/** 正式h5服务器*/
#define kMainH5Url_HTTP @"http://cockpit-h5.peogoo.com/"





#endif

#endif /* file_h */
