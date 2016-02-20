#import "NSString+PURandomFoodName.h"

@implementation NSString (PURandomName)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)randomName {
    static NSArray *__names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __names = @[@"Apples",
                    @"Bananas",
                    @"Juice",
                    @"Bread",
                    @"Cheese",
                    @"Milk",
                    @"Yogurt"];
    });

    return __names[arc4random_uniform((uint32_t)__names.count)];
}

@end
