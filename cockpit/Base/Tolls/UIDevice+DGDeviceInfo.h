//
//  UIDevice+DGDeviceInfo.h
//  DiscipleGroup
//
//  Created by houqiuhe on 2020/6/24.
//  Copyright © 2020 maxudong. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (DGDeviceInfo)

/// @see http://theiphonewiki.com/wiki/Models
@property (nullable, nonatomic, readonly) NSString *deviceModelName;
@property (nullable, nonatomic, readonly) NSString *login_device_version;

@end

NS_ASSUME_NONNULL_END
