#import <Foundation/Foundation.h>

@interface LCHContainer : NSObject
@property (nonatomic, readonly) NSSet   *items;

- (void)addItem:(id)item;
- (void)removeItem:(id)item;

@end
