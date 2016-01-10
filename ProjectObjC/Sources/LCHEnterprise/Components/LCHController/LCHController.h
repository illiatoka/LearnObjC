#import <Foundation/Foundation.h>

@interface LCHController : NSObject

+ (instancetype)controllerWithEnterprise:(id)enterprise;

- (instancetype)initWIthEnterprise:(id)enterprise;

- (void)performWorkWithObject:(id)object;
- (void)performWorkWithObjects:(NSArray *)objects;

@end
