#import <Foundation/Foundation.h>

#import "PUObservableObject.h"

@class PUListItem;

@interface PUList : PUObservableObject
@property (nonatomic, readonly) NSArray     *items;
@property (nonatomic, readonly) NSUInteger  count;

- (PUListItem *)objectAtIndex:(NSUInteger)index;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)removeObjectAtIndex:(NSUInteger)index;

@end
