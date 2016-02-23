#import <UIKit/UIKit.h>

@interface UITableView (PUExtensions)

- (id)cellWithClass:(Class)cls;

- (void)updateWithBlock:(void(^)(UITableView *))block;
- (void)updateWithBlock:(void(^)(UITableView *))block completion:(void(^)(UITableView *))comletion;

@end
