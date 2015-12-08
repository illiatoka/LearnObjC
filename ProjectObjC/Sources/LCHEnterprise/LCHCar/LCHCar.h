#import <Foundation/Foundation.h>

@interface LCHCar : NSObject
@property (nonatomic, readwrite, assign) NSUInteger cash;
@property (nonatomic, readwrite, assign) BOOL isClean;

+ (instancetype)car;

@end
