//
//  JKRMergeSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRMergeSort.h"

@interface JKRMergeSort ()

@property (nonatomic, strong) JKRArrayList *leftArray;

@end

@implementation JKRMergeSort

- (void)sort {
    self.leftArray = [JKRArrayList arrayWithCapacity:_array.count >> 1];
    [self sortWithBeigin:0 end:_array.count];
}

- (void)sortWithBeigin:(NSInteger)begin end:(NSInteger)end {
    if (end - begin < 2) return;
    
    NSInteger mid = (begin + end) >> 1;
    [self sortWithBeigin:begin end:mid];
    [self sortWithBeigin:mid end:end];
    
    [self mergeWithBegin:begin mid:mid end:end];
}

- (void)mergeWithBegin:(NSInteger)begin mid:(NSInteger)mid end:(NSInteger)end {
    NSInteger li = 0, le = mid - begin;
    NSInteger ri = mid, re = end;
    NSInteger ai = begin;
    
    for (NSInteger i = li; i < le; i++) {
        _leftArray[i] = _array[begin + i];
    }
    
    while (li < le) {
        if (ri < re && [self compareWithObject0:_array[ri] object1:_leftArray[li]] == NSOrderedAscending) {
            _array[ai++] = _array[ri++];
        } else {
            _array[ai++] = _leftArray[li++];
        }
    }
}

@end

