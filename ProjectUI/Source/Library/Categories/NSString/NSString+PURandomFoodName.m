#import "NSString+PURandomFoodName.h"

@implementation NSString (PURandomName)

+ (instancetype)randomName {
    NSArray *names = @[@"Apples",
                       @"Bananas",
                       @"Juice",
                       @"Bread",
                       @"Cheese",
                       @"Milk",
                       @"Yogurt"];
    
    
    return names[arc4random_uniform((uint32_t)names.count)];
}

@end
