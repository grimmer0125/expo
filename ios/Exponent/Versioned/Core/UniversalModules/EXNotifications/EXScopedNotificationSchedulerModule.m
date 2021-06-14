// Copyright 2018-present 650 Industries. All rights reserved.

#import "EXScopedNotificationSchedulerModule.h"
#import "EXScopedNotificationsUtils.h"
#import "EXScopedNotificationSerializer.h"
#import "EXScopedNotificationsUtils.h"

@interface EXScopedNotificationSchedulerModule ()

@property (nonatomic, strong) NSString *experienceScopeKey;

@end

@implementation EXScopedNotificationSchedulerModule

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }

  return self;
}

- (UNNotificationRequest *)buildNotificationRequestWithIdentifier:(NSString *)identifier
                                                          content:(NSDictionary *)contentInput
                                                          trigger:(NSDictionary *)triggerInput
{
  NSString *scopedIdentifier = [EXScopedNotificationsUtils scopedIdentifierFromId:identifier
                                                                    forExperience:_experienceScopeKey];
  return [super buildNotificationRequestWithIdentifier:scopedIdentifier content:contentInput trigger:triggerInput];
}

- (NSArray * _Nonnull)serializeNotificationRequests:(NSArray<UNNotificationRequest *> * _Nonnull) requests;
{
  NSMutableArray *serializedRequests = [NSMutableArray new];
  for (UNNotificationRequest *request in requests) {
    if ([EXScopedNotificationsUtils isId:request.identifier scopedByExperience:_experienceScopeKey]) {
      [serializedRequests addObject:[EXScopedNotificationSerializer serializedNotificationRequest:request]];
    }
  }
  return serializedRequests;
}


- (void)cancelNotification:(NSString *)identifier resolve:(UMPromiseResolveBlock)resolve rejecting:(UMPromiseRejectBlock)reject
{
  NSString *scopedIdentifier = [EXScopedNotificationsUtils scopedIdentifierFromId:identifier
                                                                    forExperience:_experienceScopeKey];
  [super cancelNotification:scopedIdentifier resolve:resolve rejecting:reject];
}

- (void)cancelAllNotificationsWithResolver:(UMPromiseResolveBlock)resolve rejecting:(UMPromiseRejectBlock)reject
{
  __block NSString *experienceScopeKey = _experienceScopeKey;
  [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
    NSMutableArray<NSString *> *toRemove = [NSMutableArray new];
    for (UNNotificationRequest *request in requests) {
      if ([EXScopedNotificationsUtils isId:request.identifier scopedByExperience:experienceScopeKey]) {
        [toRemove addObject:request.identifier];
      }
    }
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:toRemove];
    resolve(nil);
  }];
}

@end
