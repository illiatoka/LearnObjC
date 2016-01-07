#import <Foundation/Foundation.h>

@interface LCHContainer : NSObject
@property (nonatomic, readonly) NSArray *items;

- (void)addItem:(id)item;
- (void)removeItem:(id)item;

@end
