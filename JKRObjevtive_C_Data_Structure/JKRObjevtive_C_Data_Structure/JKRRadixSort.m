//
//  JKRRadixSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/18.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRRadixSort.h"
#import "JKRArray.h"

@implementation JKRRadixSort

- (void)sort {
    NSInteger max = _array[0].integerValue;
    
    for (NSInteger i = 1; i < _array.count; i++) {
        if (_array[i].integerValue > max) {
            max = _array[i].integerValue;
        }
    }
    
    for (NSInteger divider = 1; divider <= max; divider *= 10) {
        [self countSortWithDivider:divider];
    }
}

- (void)countSortWithDivider:(NSInteger)divider {
    JKRArray<NSNumber *> *counts = [JKRArray arrayWithLength:10];
    
    for (NSInteger i = 0; i < _array.count; i++) {
        counts[_array[i].integerValue / divider % 10] = [NSNumber numberWithInteger:counts[_array[i].integerValue / divider % 10].integerValue + 1];
    }
    
    for (NSInteger i = 1; i < counts.length; i++) {
        counts[i] = [NSNumber numberWithInteger:counts[i].integerValue + counts[i - 1].integerValue];
    }
    
    JKRArray<NSNumber *> *newArray = [JKRArray arrayWithLength:_array.count];
    for (NSInteger i = _array.count - 1; i >= 0; i--) {
        counts[_array[i].integerValue / divider % 10] = [NSNumber numberWithInteger:counts[_array[i].integerValue / divider % 10].integerValue - 1];
        newArray[counts[_array[i].integerValue / divider % 10].integerValue] = _array[i];
    }
    
    for (NSInteger i = 0; i < newArray.length; i++) {
        _array[i] = newArray[i];
    }
}

- (BOOL)isStable {
    return YES;
}

@end
