//
//  JKRInsertionSort2.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRInsertionSort2.h"

@implementation JKRInsertionSort2

- (void)sort {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        NSInteger cur = begin;
        id value = _array[cur];
        while (cur > 0 && [self compareWithObject0:value object1:_array[cur - 1]] == NSOrderedAscending) {
            _array[cur] = _array[cur - 1];
            cur--;
        }
        _array[cur] = value;
    }
}

@end
