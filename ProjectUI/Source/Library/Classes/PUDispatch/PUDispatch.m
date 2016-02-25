#import "PUDispatch.h"

#pragma mark -
#pragma mark Publiс

void PUDispatchSyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(PUDispatchGetQueue(PUDispatchQueueMain), block);
    }
}

void PUDispatchAsyncOnMainQueue(dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(PUDispatchGetQueue(PUDispatchQueueMain), block);
}

void PUDispatchSyncOnDefaultQueue(dispatch_block_t block) {
    PUDispatchSyncOnQueue(PUDispatchQueueDefault, block);
}

void PUDispatchAsyncOnDefaultQueue(dispatch_block_t block) {
    PUDispatchAsyncOnQueue(PUDispatchQueueDefault, block);
}

void PUDispatchSyncOnBackgroundQueue(dispatch_block_t block) {
    PUDispatchSyncOnQueue(PUDispatchQueueBackground, block);
}

void PUDispatchAsyncOnBackgroundQueue(dispatch_block_t block) {
    PUDispatchAsyncOnQueue(PUDispatchQueueBackground, block);
}

void PUDispatchSyncOnQueue(PUDispatchQueueType type, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_sync(PUDispatchGetQueue(type), block);
}

void PUDispatchAsyncOnQueue(PUDispatchQueueType type, dispatch_block_t block) {
    if (!block) {
        return;
    }
    
    dispatch_async(PUDispatchGetQueue(type), block);
}

dispatch_queue_t PUDispatchGetQueue(PUDispatchQueueType type) {
    switch (type) {
        case PUDispatchQueueMain:
            return dispatch_get_main_queue();
            
        default:
            return dispatch_get_global_queue(type, 0);
    }
}
