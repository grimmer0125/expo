// Copyright 2015-present 650 Industries. All rights reserved.

#import "EXDevSettings.h"
#import "EXDevSettingsDataSource.h"

// redefined from RCTDevMenu.mm
NSString *const kRCTDevSettingShakeToShowDevMenu = @"shakeToShow";
NSString *const kRCTDevSettingLiveReloadEnabled = @"liveReloadEnabled";
NSString *const kRCTDevSettingHotLoadingEnabled = @"hotLoadingEnabled";

@implementation EXDevSettings

+ (NSString *)moduleName { return @"RCTDevSettings"; }

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey isDevelopment:(BOOL)isDevelopment
{
  NSDictionary *defaultValues = @{
                                  kRCTDevSettingShakeToShowDevMenu: @YES,
                                  kRCTDevSettingHotLoadingEnabled: @YES,
                                  kRCTDevSettingLiveReloadEnabled: @NO,
                                  };
  EXDevSettingsDataSource *dataSource = [[EXDevSettingsDataSource alloc] initWithDefaultValues:defaultValues
                                                                         forExperienceScopeKey:experienceScopeKey
                                                                                 isDevelopment:isDevelopment];
  return [super initWithDataSource:dataSource];
}

- (NSArray<NSString *> *)supportedEvents
{
  return [super supportedEvents];
}

@end
