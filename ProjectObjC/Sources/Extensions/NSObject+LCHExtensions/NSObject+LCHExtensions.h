#import <Foundation/Foundation.h>

@interface NSObject (LCHObjectExtensions)

+ (instancetype)object;

- (NSArray *)objectsOfClass:(Class)class withCount:(NSUInteger)count;

@end
