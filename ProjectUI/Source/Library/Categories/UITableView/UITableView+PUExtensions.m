#import "UITableView+PUExtensions.h"

#import "UINib+PUExtensions.h"

@implementation UITableView (PUExtensions)

#pragma mark -
#pragma mark Public

- (id)cellWithClass:(Class)cls {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
        cell = [UINib objectWithClass:cls];
    }
    
    return cell;
}

- (void)updateWithBlock:(void(^)(UITableView *))block {
    [self updateWithBlock:block completion:nil];
}

- (void)updateWithBlock:(void(^)(UITableView *))block completion:(void(^)(UITableView *))completion {
    if (block) {
        [self beginUpdates];
        block(self);
        [self endUpdates];
        
        if (completion) {
            completion(self);
        }
    }
}

@end
