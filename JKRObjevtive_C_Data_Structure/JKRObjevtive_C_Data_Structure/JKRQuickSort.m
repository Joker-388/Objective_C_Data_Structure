//
//  JKRQuickSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/11.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRQuickSort.h"

@implementation JKRQuickSort

- (void)sort {
    [self sortWithBegin:0 end:_array.count];
}

- (void)sortWithBegin:(NSInteger)begin end:(NSInteger)end {
    if (end - begin < 2) return;
    
    NSInteger mid = [self pivotIndexWithBegin:begin end:end];;

    [self sortWithBegin:begin end:mid];
    [self sortWithBegin:mid + 1 end:end];
}

- (NSInteger)pivotIndexWithBegin:(NSInteger)begin end:(NSInteger)end {
    [self swapWithIndex0:begin index1:begin + (NSInteger)(arc4random() % (end - begin))];
    
    id pivot = _array[begin];
    end--;
    
    while (begin < end) {
        while (begin < end) {
            if ([self compareWithObject0:pivot object1:_array[end]] == NSOrderedAscending) {
                end--;
            } else {
                _array[begin++] = _array[end];
                break;
            }
        }
        
        while (begin < end) {
            if ([self compareWithObject0:pivot object1:_array[begin]] == NSOrderedDescending) {
                begin++;
            } else {
                _array[end--] = _array[begin];
                break;
            }
        }
    }
    
    _array[begin] = pivot;
    return begin;
}

@end
