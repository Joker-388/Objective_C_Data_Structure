//
//  JKRHeapSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/30.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHeapSort.h"

@interface JKRHeapSort ()

@property (nonatomic, assign) NSUInteger heapSize;

@end

@implementation JKRHeapSort

- (void)sort {
    _heapSize = _array.count;
    for (NSInteger i = (_heapSize >> 1) - 1; i >= 0; i--) {
        [self siftDownWithIndex:i];
    }
    
    while (_heapSize > 1) {
        [self swapWithIndex0:0 index1:--_heapSize];
        [self siftDownWithIndex:0];
    }
}

- (void)siftDownWithIndex:(NSUInteger)index {
    id element = _array[index];
    
    NSUInteger half = _heapSize >> 1;
    while (index < half) {
        NSUInteger childIndex = (index << 1) + 1;
        id child = _array[childIndex];
        
        NSUInteger rightIndex = childIndex + 1;
        
        if (rightIndex < _heapSize && [self compareWithObject0:_array[rightIndex] object1:child] == NSOrderedDescending) {
            child = _array[childIndex = rightIndex];
        }
        
        if ([self compareWithObject0:element object1:child] != NSOrderedAscending) {
            break;
        }
        
        _array[index] = child;
        index = childIndex;
    }
    _array[index] = element;
}

@end
