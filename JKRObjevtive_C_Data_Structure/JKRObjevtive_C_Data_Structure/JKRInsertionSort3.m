//
//  JKRInsertionSort3.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRInsertionSort3.h"

@implementation JKRInsertionSort3

- (void)sort {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        [self insertWithSource:begin dest:[self searchWithIndex:begin]];
    }
}

- (void)insertWithSource:(NSInteger)source dest:(NSInteger)dest {
    id value = _array[source];
    for (NSInteger i = source; i > dest; i--) {
        _array[i] = _array[i - 1];
    }
    _array[dest] = value;
}

- (NSInteger)searchWithIndex:(NSInteger)index {
    NSInteger begin = 0;
    NSInteger end = index;
    
    while (begin < end) {
        NSInteger mid = (begin + end) >> 1;
        if ([self compareWithObject0:_array[index] object1:_array[mid]] == NSOrderedAscending) {
            end = mid;
        } else {
            begin = mid + 1;
        }
    }
    
    return begin;
}

@end
