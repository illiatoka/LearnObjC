#import <Foundation/Foundation.h>

@interface LCHContainer : NSObject
@property (nonatomic, readonly) NSSet   *items;

+ (instancetype)container;

- (void)addItem:(id)item;
- (void)removeItem:(id)item;

@end
