//  Copyright © 2021 650 Industries. All rights reserved.

#import <EXUpdates/EXUpdatesRawManifest.h>
#import <EXUpdates/EXUpdatesBaseRawManifest.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXUpdatesNewRawManifest : EXUpdatesBaseRawManifest<EXUpdatesRawManifestBehavior>

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
