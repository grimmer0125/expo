// Copyright 2018-present 650 Industries. All rights reserved.

#if __has_include(<ABI40_0_0EXErrorRecovery/ABI40_0_0EXErrorRecoveryModule.h>)
#import "ABI40_0_0EXScopedErrorRecoveryModule.h"

@interface ABI40_0_0EXScopedErrorRecoveryModule ()

@property (nonatomic, strong) NSString *experienceScopeKey;

@end

@implementation ABI40_0_0EXScopedErrorRecoveryModule

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  return self;
}

- (BOOL)setRecoveryProps:(NSString *)props
{
  NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
  NSDictionary *errorRecoveryStore = [preferences dictionaryForKey:[self userDefaultsKey]] ?: @{};
  NSMutableDictionary *newStore = [errorRecoveryStore mutableCopy];
  newStore[_experienceScopeKey] = props;
  [preferences setObject:newStore forKey:[self userDefaultsKey]];
  return [preferences synchronize];
}

- (NSString *)consumeRecoveryProps
{
  NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
  NSDictionary *errorRecoveryStore = [preferences dictionaryForKey:[self userDefaultsKey]];
  if (errorRecoveryStore) {
    NSString *props = errorRecoveryStore[_experienceScopeKey];
    if (props) {
      NSMutableDictionary *storeWithRemovedProps = [errorRecoveryStore mutableCopy];
      [storeWithRemovedProps removeObjectForKey:_experienceScopeKey];
      [preferences setObject:storeWithRemovedProps forKey:[self userDefaultsKey]];
      [preferences synchronize];
      return props;
    }
  }
  return nil;
}

@end
#endif
