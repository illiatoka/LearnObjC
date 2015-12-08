#import <Foundation/Foundation.h>

@class LCHBuilding;
@class LCHOffice;
@class LCHCarWash;

@interface LCHEnterprise : NSObject
@property (nonatomic, readonly) NSSet *buildings;

+ (instancetype)enterprise;
+ (instancetype)enterpriseWithOffice:(LCHOffice *)office carWash:(LCHCarWash *)carWash;

- (instancetype)initWithOffice:(LCHOffice *)office carWash:(LCHCarWash *)carWash;

- (NSUInteger)countOfEmployees;
- (NSUInteger)countOfBuildings;
- (NSUInteger)countOfRooms;

- (void)addBuilding:(LCHBuilding *)building;
- (void)removeBuilding:(LCHBuilding *)building;

@end
