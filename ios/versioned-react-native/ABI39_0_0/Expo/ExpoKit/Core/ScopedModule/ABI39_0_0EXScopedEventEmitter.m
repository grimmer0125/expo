// Copyright 2015-present 650 Industries. All rights reserved.

#import "ABI39_0_0EXScopedEventEmitter.h"

@implementation ABI39_0_0EXScopedEventEmitter

+ (NSString *)moduleName
{
  NSAssert(NO, @"ABI39_0_0EXScopedEventEmitter is abstract, you should only export subclasses to the bridge.");
  return @"ExponentScopedEventEmitter";
}

+ (NSString *)getExperienceScopeKeyFromEventEmitter:(id)eventEmitter
{
  if (eventEmitter) {
    return ((ABI39_0_0EXScopedEventEmitter *)eventEmitter).experienceScopeKey;
  }
  return nil;
}

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey kernelServiceDelegate:(id)kernelServiceInstance params:(NSDictionary *)params
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  return self;
}

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey kernelServiceDelegates:(NSDictionary *)kernelServiceInstances params:(NSDictionary *)params
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
  }
  return self;
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[];
}

@end
