#import "PUShopListItems.h"

#import "PUShopListItem.h"
#import "PUDispatch.h"

#import "NSString+PURandomFoodName.h"

static const NSUInteger kPUShopListItemCount = 20;

static NSString * const kPUItemsKey = @"items";

@interface PUShopListItems ()

- (void)fillWithBlock:(PUVoidBlock)block;

@end

@implementation PUShopListItems

@dynamic cached;

#pragma mark -
#pragma mark Accessors

- (BOOL)isCached {
    return NO;
}

#pragma mark -
#pragma mark Private

- (void)fillWithBlock:(PUVoidBlock)block {
    if (block) {
        block();
        
        // Just for testing the activity indicator
        sleep(2);
        PUDispatchAsyncOnMainQueue(^{
            self.state = PUModelStateDidLoad;
        });
    }
}

#pragma mark -
#pragma mark PUModel

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.items toFile:self.filePath];
}

- (void)load {
    self.state = PUModelStateLoading;
    
    PUDispatchAsyncOnBackgroundQueue(^{
        NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
        PUVoidBlock block = nil;
        
        if (items) {
            block = ^{
                [self performWithoutNotification:^{
                    for (id item in items) {
                        [self addObject:item];
                    }
                }];
            };
        } else {
            block = ^{
                for (NSUInteger count = 0; count < kPUShopListItemCount; count++) {
                    [self performWithoutNotification:^{
                        [self addObject:[PUShopListItem shopListItemWithName:[NSString randomName]]];
                    }];
                }
            };
        }
        
        [self fillWithBlock:block];
    });
}

#pragma mark -
#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.items forKey:kPUItemsKey];
}

@end
