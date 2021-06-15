// Copyright © 2018 650 Industries. All rights reserved.

#import "ABI39_0_0EXSensorsManagerBinding.h"

@interface ABI39_0_0EXSensorsManagerBinding ()

@property (nonatomic, strong) NSString *experienceScopeKey;
@property (nonatomic, weak) id<ABI39_0_0EXSensorsManagerBindingDelegate> kernelService;

@end

@implementation ABI39_0_0EXSensorsManagerBinding

- (instancetype)initWithExperienceScopeKey:(NSString *)experienceScopeKey andKernelService:(id<ABI39_0_0EXSensorsManagerBindingDelegate>)kernelService
{
  if (self = [super init]) {
    _experienceScopeKey = experienceScopeKey;
    _kernelService = kernelService;
  }
  return self;
}

- (void)sensorModuleDidSubscribeForAccelerometerUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForAccelerometerUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidSubscribeForDeviceMotionUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForDeviceMotionUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidSubscribeForGyroscopeUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForGyroscopeUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidSubscribeForMagnetometerUncalibratedUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForMagnetometerUncalibratedUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidSubscribeForMagnetometerUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForMagnetometerUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidSubscribeForBarometerUpdates:(id)scopedSensorModule withHandler:(void (^)(NSDictionary *))handlerBlock {
  [_kernelService sensorModuleDidSubscribeForBarometerUpdatesOfExperience:_experienceScopeKey withHandler:handlerBlock];
}

- (void)sensorModuleDidUnsubscribeForAccelerometerUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForAccelerometerUpdatesOfExperience:_experienceScopeKey];
}

- (void)sensorModuleDidUnsubscribeForDeviceMotionUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForDeviceMotionUpdatesOfExperience:_experienceScopeKey];
}

- (void)sensorModuleDidUnsubscribeForGyroscopeUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForGyroscopeUpdatesOfExperience:_experienceScopeKey];
}

- (void)sensorModuleDidUnsubscribeForMagnetometerUncalibratedUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForMagnetometerUncalibratedUpdatesOfExperience:_experienceScopeKey];
}

- (void)sensorModuleDidUnsubscribeForMagnetometerUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForMagnetometerUpdatesOfExperience:_experienceScopeKey];
}

- (void)sensorModuleDidUnsubscribeForBarometerUpdates:(id)scopedSensorModule {
  [_kernelService sensorModuleDidUnsubscribeForBarometerUpdatesOfExperience:_experienceScopeKey];
}

- (void)setAccelerometerUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setAccelerometerUpdateInterval:intervalMs];
}

- (BOOL)isAccelerometerAvailable {
  return [_kernelService isAccelerometerAvailable];
}

- (void)setDeviceMotionUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setDeviceMotionUpdateInterval:intervalMs];
}

- (float)getGravity {
  return [_kernelService getGravity];
}

- (BOOL)isDeviceMotionAvailable {
  return [_kernelService isDeviceMotionAvailable];
}

- (void)setGyroscopeUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setGyroscopeUpdateInterval:intervalMs];
}

- (BOOL)isGyroAvailable {
  return [_kernelService isGyroAvailable];
}

- (void)setMagnetometerUncalibratedUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setMagnetometerUncalibratedUpdateInterval:intervalMs];
}

- (BOOL)isMagnetometerUncalibratedAvailable {
  return [_kernelService isMagnetometerUncalibratedAvailable];
}

- (void)setMagnetometerUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setMagnetometerUpdateInterval:intervalMs];
}

- (BOOL)isMagnetometerAvailable {
  return [_kernelService isMagnetometerAvailable];
}

- (void)setBarometerUpdateInterval:(NSTimeInterval)intervalMs {
  [_kernelService setBarometerUpdateInterval:intervalMs];
}

- (BOOL)isBarometerAvailable {
  return [_kernelService isBarometerAvailable];
}


+ (const NSArray<Protocol *> *)exportedInterfaces {
  return @[@protocol(ABI39_0_0UMAccelerometerInterface), @protocol(ABI39_0_0UMBarometerInterface),  @protocol(ABI39_0_0UMDeviceMotionInterface), @protocol(ABI39_0_0UMGyroscopeInterface), @protocol(ABI39_0_0UMMagnetometerInterface), @protocol(ABI39_0_0UMMagnetometerUncalibratedInterface)];
}

@end
