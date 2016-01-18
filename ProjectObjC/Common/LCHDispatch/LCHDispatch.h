#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCHDispatchQueueType) {
    LCHDispatchQueueInterective = QOS_CLASS_USER_INTERACTIVE,
    LCHDispatchQueueInitiated = QOS_CLASS_USER_INITIATED,
    LCHDispatchQueueDefault = QOS_CLASS_DEFAULT,
    LCHDispatchQueueUtility = QOS_CLASS_UTILITY,
    LCHDispatchQueueBackground = QOS_CLASS_BACKGROUND,
    LCHDispatchQueueMain
};

extern
void LCHDispatchSyncOnMainQueue(dispatch_block_t block);

extern
void LCHDispatchAsyncOnMainQueue(dispatch_block_t block);

extern
void LCHDispatchSyncOnBackgroundQueue(dispatch_block_t block);

extern
void LCHDispatchAsyncOnBackgroundQueue(dispatch_block_t block);

extern
void LCHDispatchSyncOnQueue(LCHDispatchQueueType type, dispatch_block_t block);

extern
void LCHDispatchAsyncOnQueue(LCHDispatchQueueType type, dispatch_block_t block);

extern
dispatch_queue_t LCHDispatchGetQueue(LCHDispatchQueueType type);
