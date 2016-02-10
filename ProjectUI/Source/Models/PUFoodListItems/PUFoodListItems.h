#import <Foundation/Foundation.h>

#import "PUObservableObject.h"

@class PUFoodListItem;

@interface PUFoodListItems : PUObservableObject
@property (nonatomic, readonly) NSArray     *items;
@property (nonatomic, readonly) NSUInteger  count;

- (PUFoodListItem *)objectAtIndex:(NSUInteger)index;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)removeObjectAtIndex:(NSUInteger)index;

@end
