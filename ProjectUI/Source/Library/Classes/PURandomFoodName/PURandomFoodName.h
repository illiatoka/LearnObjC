#import <Foundation/Foundation.h>

@interface PURandomFoodName : NSObject
@property (nonatomic, readonly) NSArray *foodNames;

- (NSString *)randomFoodName;

@end
