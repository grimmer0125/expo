// Copyright 2018-present 650 Industries. All rights reserved.

#if __has_include(<EXNotifications/EXNotificationsEmitter.h>)

#import "EXScopedNotificationsEmitter.h"
#import "EXScopedNotificationsUtils.h"
#import "EXScopedNotificationSerializer.h"

@interface EXScopedNotificationsEmitter ()

@property (nonatomic, strong) NSString *experienceScopeKey;

@end

@interface EXNotificationsEmitter (Protected)

- (NSDictionary *)serializedNotification:(UNNotification *)notification;
- (NSDictionary *)serializedNotificationResponse:(UNNotificationResponse *)notificationResponse;

@end

@implementation EXScopedNotificationsEmitter

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  
  return self;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  if ([EXScopedNotificationsUtils shouldNotification:response.notification beHandledByExperience:_experienceScopeKey]) {
    [super userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
  } else {
    completionHandler();
  }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
  if ([EXScopedNotificationsUtils shouldNotification:notification beHandledByExperience:_experienceScopeKey]) {
    [super userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
  } else {
    completionHandler(UNNotificationPresentationOptionNone);
  }
}

- (NSDictionary *)serializedNotification:(UNNotification *)notification
{
  return [EXScopedNotificationSerializer serializedNotification:notification];
}

- (NSDictionary *)serializedNotificationResponse:(UNNotificationResponse *)notificationResponse
{
  return [EXScopedNotificationSerializer serializedNotificationResponse:notificationResponse];
}

@end

#endif
