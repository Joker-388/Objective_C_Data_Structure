//
//  JKRCountingSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/17.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRCountingSort.h"
#import "JKRArray.h"

@implementation JKRCountingSort

- (void)sort {
    NSInteger max = _array[0].integerValue;
    NSInteger min = _array[0].integerValue;
    
    for (NSInteger i = 1; i < _array.count; i++) {
        if (_array[i].integerValue > max) {
            max = _array[i].integerValue;
        }
        if (_array[i].integerValue < min) {
            min = _array[i].integerValue;
        }
    }
    
    JKRArray<NSNumber *> *counts = [JKRArray arrayWithLength:max - min + 1];
    
    for (NSInteger i = 0; i < _array.count; i++) {
        counts[_array[i].integerValue - min] = [NSNumber numberWithInteger:counts[_array[i].integerValue - min].integerValue + 1];
    }
    
    for (NSInteger i = 1; i < counts.length; i++) {
        counts[i] = [NSNumber numberWithInteger:counts[i].integerValue + counts[i - 1].integerValue];
    }
    
    JKRArray<NSNumber *> *newArray = [JKRArray arrayWithLength:_array.count];
    for (NSInteger i = _array.count - 1; i >= 0; i--) {
        counts[_array[i].integerValue - min] = [NSNumber numberWithInteger:counts[_array[i].integerValue - min].integerValue - 1];
        newArray[counts[_array[i].integerValue - min].integerValue] = _array[i];
    }
    
    for (NSInteger i = 0; i < newArray.length; i++) {
        _array[i] = newArray[i];
    }
 }

- (BOOL)isStable {
    return YES;
}

@end
