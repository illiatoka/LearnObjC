#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PUDispatchQueueType) {
    PUDispatchQueueInteractive = QOS_CLASS_USER_INTERACTIVE,
    PUDispatchQueueInitiated = QOS_CLASS_USER_INITIATED,
    PUDispatchQueueDefault = QOS_CLASS_DEFAULT,
    PUDispatchQueueUtility = QOS_CLASS_UTILITY,
    PUDispatchQueueBackground = QOS_CLASS_BACKGROUND,
    PUDispatchQueueMain
};

extern
void PUDispatchSyncOnMainQueue(dispatch_block_t block);

extern
void PUDispatchAsyncOnMainQueue(dispatch_block_t block);

extern
void PUDispatchSyncOnBackgroundQueue(dispatch_block_t block);

extern
void PUDispatchAsyncOnBackgroundQueue(dispatch_block_t block);

extern
void PUDispatchSyncOnQueue(PUDispatchQueueType type, dispatch_block_t block);

extern
void PUDispatchAsyncOnQueue(PUDispatchQueueType type, dispatch_block_t block);

extern
dispatch_queue_t PUDispatchGetQueue(PUDispatchQueueType type);
