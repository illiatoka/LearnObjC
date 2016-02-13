#import "UINib+PUExtensions.h"

@implementation UINib (PUExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)nibWithClass:(Class)class {
    return [self nibWithClass:class bundle:nil];
}

+ (instancetype)nibWithClass:(Class)class bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(class) bundle:bundle];
}

+ (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

+ (id)objectWithClass:(Class)class owner:(id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}

+ (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    return [[self nibWithClass:class] objectWithClass:class owner:owner options:options];
}

#pragma mark -
#pragma mark Public

- (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:nil options:nil];
    for (id object in objects) {
        if ([object isMemberOfClass:class]) {
            return object;
        }
    }
    
    return nil;
}

@end
