// Copyright 2018-present 650 Industries. All rights reserved.

#import "ABI40_0_0EXScopedNotificationsUtils.h"

@implementation ABI40_0_0EXScopedNotificationsUtils

+ (BOOL)shouldNotificationRequest:(UNNotificationRequest *)request beHandledByExperience:(NSString *)experienceScopeKey
{
  NSString *notificationExperienceScopeKey = request.content.userInfo[@"experienceId"];
  if (!notificationExperienceScopeKey) {
    return true;
  }
  return [notificationExperienceScopeKey isEqual:experienceScopeKey];
}

+ (BOOL)shouldNotification:(UNNotification *)notification beHandledByExperience:(NSString *)experienceScopeKey
{
  return [ABI40_0_0EXScopedNotificationsUtils shouldNotificationRequest:notification.request beHandledByExperience:experienceScopeKey];
}

@end
