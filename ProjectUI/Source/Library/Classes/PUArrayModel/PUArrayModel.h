#import "PUObservableObject.h"

#import "PUArrayModelObserver.h"

@interface PUArrayModel : PUObservableObject
@property (nonatomic, readonly) NSArray     *items;
@property (nonatomic, readonly) NSUInteger  count;

- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)moveObjectAtIndex:(NSUInteger)idx1 toIndex:(NSUInteger)idx2;

- (void)removeObjectAtIndex:(NSUInteger)index;

@end
