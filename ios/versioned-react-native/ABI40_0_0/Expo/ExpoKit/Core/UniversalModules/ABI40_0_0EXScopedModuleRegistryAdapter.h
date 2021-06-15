// Copyright © 2018 650 Industries. All rights reserved.

#import <ABI40_0_0UMReactNativeAdapter/ABI40_0_0UMModuleRegistryAdapter.h>

@interface ABI40_0_0EXScopedModuleRegistryAdapter : ABI40_0_0UMModuleRegistryAdapter

- (ABI40_0_0UMModuleRegistry *)moduleRegistryForParams:(NSDictionary *)params
                  forExperienceStableLegacyId:(NSString *)experienceStableLegacyId
                           experienceScopeKey:(NSString *)experienceScopeKey
                           withKernelServices:(NSDictionary *)kernelServices;

@end
