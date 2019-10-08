//
//  JKRInsertionSort1.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRInsertionSort1.h"

@implementation JKRInsertionSort1

- (void)sort {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        NSInteger cur = begin;
        while (cur > 0 && [self compareWithIndex0:cur index1:cur - 1] == NSOrderedAscending) {
            [self swapWithIndex0:cur index1:cur - 1];
            cur--;
        }
    }
}

@end
