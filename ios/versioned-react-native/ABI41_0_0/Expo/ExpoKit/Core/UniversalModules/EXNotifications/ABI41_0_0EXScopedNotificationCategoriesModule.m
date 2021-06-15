// Copyright 2018-present 650 Industries. All rights reserved.

#import "ABI41_0_0EXScopedNotificationCategoriesModule.h"
#import "ABI41_0_0EXScopedNotificationCategoryMigrator.h"
#import "ABI41_0_0EXScopedNotificationsUtils.h"

@interface ABI41_0_0EXScopedNotificationCategoriesModule ()

@property (nonatomic, strong) NSString *experienceScopeKey;

@end

@implementation ABI41_0_0EXScopedNotificationCategoriesModule

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey
                 andConstantsBinding:(ABI41_0_0EXConstantsBinding *)constantsBinding
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  return self;
}

- (void)getNotificationCategoriesAsyncWithResolver:(ABI41_0_0UMPromiseResolveBlock)resolve reject:(ABI41_0_0UMPromiseRejectBlock)reject
{
  [[UNUserNotificationCenter currentNotificationCenter] getNotificationCategoriesWithCompletionHandler:^(NSSet<UNNotificationCategory *> *categories) {
    NSMutableArray* existingCategories = [NSMutableArray new];
    for (UNNotificationCategory *category in categories) {
      if ([ABI41_0_0EXScopedNotificationsUtils isId:category.identifier scopedByExperience:self->_experienceScopeKey]) {
        [existingCategories addObject:[self serializeCategory:category]];
      }
    }
    resolve(existingCategories);
  }];
}

- (void)setNotificationCategoryWithCategoryId:(NSString *)categoryId
                                      actions:(NSArray *)actions
                                      options:(NSDictionary *)options
                                      resolve:(ABI41_0_0UMPromiseResolveBlock)resolve
                                       reject:(ABI41_0_0UMPromiseRejectBlock)reject
{
  NSString *scopedCategoryIdentifier = [ABI41_0_0EXScopedNotificationsUtils scopedIdentifierFromId:categoryId
                                                                            forExperience:_experienceScopeKey];
  [super setNotificationCategoryWithCategoryId:scopedCategoryIdentifier
                                       actions:actions
                                       options:options
                                       resolve:resolve
                                        reject:reject];
}

- (void)deleteNotificationCategoryWithCategoryId:(NSString *)categoryId
                                         resolve:(ABI41_0_0UMPromiseResolveBlock)resolve
                                          reject:(ABI41_0_0UMPromiseRejectBlock)reject
{
  NSString *scopedCategoryIdentifier = [ABI41_0_0EXScopedNotificationsUtils scopedIdentifierFromId:categoryId
                                                                            forExperience:_experienceScopeKey];
  [super deleteNotificationCategoryWithCategoryId:scopedCategoryIdentifier
                                          resolve:resolve
                                           reject:reject];
}

- (NSMutableDictionary *)serializeCategory:(UNNotificationCategory *)category
{
  NSMutableDictionary* serializedCategory = [super serializeCategory:category];
  serializedCategory[@"identifier"] = [ABI41_0_0EXScopedNotificationsUtils getScopeAndIdentifierFromScopedIdentifier:serializedCategory[@"identifier"]].identifier;

  return serializedCategory;
}

#pragma mark - static method for migrating categories in both Expo Go and standalones. Added in SDK 41. TODO(Cruzan): Remove in SDK 47

+ (void)maybeMigrateLegacyCategoryIdentifiersForProjectWithExperienceStableLegacyId:(NSString *)experienceStableLegacyId
                                                                 experienceScopeKey:(NSString *)experienceScopeKey
                                                                         isInExpoGo:(BOOL)isInExpoGo
{
  if (isInExpoGo) {
    // Changed scoping prefix in SDK 41 FROM "experienceId-" to ESCAPED "experienceId/"
    [ABI41_0_0EXScopedNotificationCategoryMigrator migrateLegacyScopedCategoryIdentifiersForProjectWithExperienceStableLegacyId:experienceStableLegacyId];
  } else {
    // Used to prefix with "experienceId-" even in standalone apps in SDKs <= 40, so we need to unscope those
    [ABI41_0_0EXScopedNotificationCategoryMigrator unscopeLegacyCategoryIdentifiersForProjectWithExperienceStableLegacyId:experienceStableLegacyId
                                                                                              experienceScopeKey:experienceScopeKey];
  }
}

@end
