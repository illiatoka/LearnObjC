#import <Foundation/Foundation.h>

#import "PUObservableObject.h"

@class PUShopListItem;

@interface PUShopListItems : PUObservableObject
@property (nonatomic, readonly) NSArray     *items;
@property (nonatomic, readonly) NSUInteger  count;

- (PUShopListItem *)objectAtIndex:(NSUInteger)index;
- (PUShopListItem *)objectAtIndexedSubscript:(NSUInteger)index;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)removeObjectAtIndex:(NSUInteger)index;

@end
