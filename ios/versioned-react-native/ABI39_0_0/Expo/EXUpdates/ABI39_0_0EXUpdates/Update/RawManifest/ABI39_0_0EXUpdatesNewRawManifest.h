//  Copyright © 2021 650 Industries. All rights reserved.

#import <ABI39_0_0EXUpdates/ABI39_0_0EXUpdatesRawManifest.h>
#import <ABI39_0_0EXUpdates/ABI39_0_0EXUpdatesBaseRawManifest.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABI39_0_0EXUpdatesNewRawManifest : ABI39_0_0EXUpdatesBaseRawManifest<ABI39_0_0EXUpdatesRawManifestBehavior>

/**
 * An ID representing this manifest, not the ID for the experience.
 */
- (NSString *)rawId;

/**
 * Incorrect for now until we figure out how to get this in the new manifest format.
 */
- (NSString *)stableLegacyId;

/**
 * Incorrect for now until we figure out how to get this in the new manifest format.
 */
- (NSString *)scopeKey;

/**
 * Incorrect for now until we figure out how to get this in the new manifest format.
 */
- (nullable NSString *)projectId;

- (NSString *)createdAt;
- (NSString *)runtimeVersion;
- (NSDictionary *)launchAsset;
- (nullable NSArray *)assets;

@end

NS_ASSUME_NONNULL_END
