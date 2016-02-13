#import <UIKit/UIKit.h>

@interface UINib (PUExtensions)

+ (instancetype)nibWithClass:(Class)class;
+ (instancetype)nibWithClass:(Class)class bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)class;
+ (id)objectWithClass:(Class)class owner:(id)owner;
+ (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options;

- (id)objectWithClass:(Class)class;
- (id)objectWithClass:(Class)class owner:(id)owner;
- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options;

@end
