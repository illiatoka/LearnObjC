#import "LCHDispatch.h"

#pragma mark -
#pragma mark Publiс

void LCHDispatchSyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(LCHDispatchGetQueue(LCHDispatchQueueMain), block);
    }
}

void LCHDispatchAsyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(LCHDispatchGetQueue(LCHDispatchQueueMain), block);
}

void LCHDispatchSyncOnBackgroundQueue(dispatch_block_t block) {
    LCHDispatchSyncOnQueue(LCHDispatchQueueBackground, block);
}

void LCHDispatchAsyncOnBackgroundQueue(dispatch_block_t block) {
    LCHDispatchAsyncOnQueue(LCHDispatchQueueBackground, block);
}

void LCHDispatchSyncOnQueue(LCHDispatchQueueType type, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(LCHDispatchGetQueue(type), block);
}

void LCHDispatchAsyncOnQueue(LCHDispatchQueueType type, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(LCHDispatchGetQueue(type), block);
}

dispatch_queue_t LCHDispatchGetQueue(LCHDispatchQueueType type) {
    switch (type) {
        case LCHDispatchQueueMain:
            return dispatch_get_main_queue();
            
        default:
            return dispatch_get_global_queue(type, 0);
    }
}
