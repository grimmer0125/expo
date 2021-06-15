// Copyright 2018-present 650 Industries. All rights reserved.

#import "EXScopedNotificationCategoriesModule.h"
#import "EXScopedNotificationCategoryMigrator.h"
#import "EXScopedNotificationsUtils.h"

@interface EXScopedNotificationCategoriesModule ()

@property (nonatomic, strong) NSString *experienceScopeKey;

@end

@implementation EXScopedNotificationCategoriesModule

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey
                       andConstantsBinding:(EXConstantsBinding *)constantsBinding
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  return self;
}

- (void)getNotificationCategoriesAsyncWithResolver:(UMPromiseResolveBlock)resolve reject:(UMPromiseRejectBlock)reject
{
  [[UNUserNotificationCenter currentNotificationCenter] getNotificationCategoriesWithCompletionHandler:^(NSSet<UNNotificationCategory *> *categories) {
    NSMutableArray* existingCategories = [NSMutableArray new];
    for (UNNotificationCategory *category in categories) {
      if ([EXScopedNotificationsUtils isId:category.identifier scopedByExperience:self->_experienceScopeKey]) {
        [existingCategories addObject:[self serializeCategory:category]];
      }
    }
    resolve(existingCategories);
  }];
}

- (void)setNotificationCategoryWithCategoryId:(NSString *)categoryId
                                      actions:(NSArray *)actions
                                      options:(NSDictionary *)options
                                      resolve:(UMPromiseResolveBlock)resolve
                                       reject:(UMPromiseRejectBlock)reject
{
  NSString *scopedCategoryIdentifier = [EXScopedNotificationsUtils scopedIdentifierFromId:categoryId
                                                                            forExperience:_experienceScopeKey];
  [super setNotificationCategoryWithCategoryId:scopedCategoryIdentifier
                                       actions:actions
                                       options:options
                                       resolve:resolve
                                        reject:reject];
}

- (void)deleteNotificationCategoryWithCategoryId:(NSString *)categoryId
                                         resolve:(UMPromiseResolveBlock)resolve
                                          reject:(UMPromiseRejectBlock)reject
{
  NSString *scopedCategoryIdentifier = [EXScopedNotificationsUtils scopedIdentifierFromId:categoryId
                                                                            forExperience:_experienceScopeKey];
  [super deleteNotificationCategoryWithCategoryId:scopedCategoryIdentifier
                                          resolve:resolve
                                           reject:reject];
}

- (NSMutableDictionary *)serializeCategory:(UNNotificationCategory *)category
{
  NSMutableDictionary* serializedCategory = [super serializeCategory:category];
  serializedCategory[@"identifier"] = [EXScopedNotificationsUtils getScopeAndIdentifierFromScopedIdentifier:serializedCategory[@"identifier"]].identifier;

  return serializedCategory;
}

#pragma mark - static method for migrating categories in both Expo Go and standalones. Added in SDK 41. TODO(Cruzan): Remove in SDK 47

+ (void)maybeMigrateLegacyCategoryIdentifiersForProjectWithExperienceStableLegacyId:(NSString *)experienceStableLegacyId
                                                                 experienceScopeKey:(NSString *)experienceScopeKey
                                                                         isInExpoGo:(BOOL)isInExpoGo
{
  if (isInExpoGo) {
    // Changed scoping prefix in SDK 41 FROM "experienceId-" to ESCAPED "experienceId/"
    [EXScopedNotificationCategoryMigrator migrateLegacyScopedCategoryIdentifiersForProjectWithExperienceStableLegacyId:experienceStableLegacyId
                                                                                                    experienceScopeKey:experienceScopeKey];
  } else {
    // Used to prefix with "experienceId-" even in standalone apps in SDKs <= 40, so we need to unscope those
    [EXScopedNotificationCategoryMigrator unscopeLegacyCategoryIdentifiersForProjectWithExperienceStableLegacyId:experienceStableLegacyId];
  }
}

@end
