#import <Foundation/Foundation.h>

@class LCHEnterprise;
@class LCHCar;

@interface LCHController : NSObject
@property (nonatomic, readonly) LCHEnterprise *enterprise;

+ (instancetype)controllerWithEnterprise:(LCHEnterprise *)enterprise;

- (instancetype)initWithEnterprise:(LCHEnterprise *)enterprise;

- (void)performBackgroundWorkWithCar:(LCHCar *)car;
- (void)performBackgroundWorkWithCars:(NSSet *)cars;

@end
