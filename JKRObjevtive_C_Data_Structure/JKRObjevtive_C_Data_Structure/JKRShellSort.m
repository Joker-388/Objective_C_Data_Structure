//
//  JKRShellSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/16.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRShellSort.h"
#import <math.h>

@implementation JKRShellSort

- (void)sort {
    JKRArrayList<NSNumber *> *stepSequence = [self sedgewickStepSequence];
    for (NSNumber *step in stepSequence) {
        [self sortWithStep:step.integerValue];
    }
}

- (void)sortWithStep:(NSInteger)step {
    for (NSInteger col = 0; col < step; col++) {
        for (NSInteger begin = col + step; begin < _array.count; begin += step) {
            NSInteger cur = begin;
            while (cur > col && [self compareWithIndex0:cur index1:cur - step] == NSOrderedAscending) {
                [self swapWithIndex0:cur index1:cur - step];
                cur -= step;
            }
        }
    }
}

/// n 的平方
- (JKRArrayList<NSNumber *> *)shellStepSequence {
    JKRArrayList<NSNumber *> *stepSequence = [JKRArrayList array];
    NSInteger step = _array.count;
    while ((step >>= 1) > 0) {
        [stepSequence addObject:[NSNumber numberWithInteger:step]];
    }
    return stepSequence;
}

/// n 的 3/4 次方，1，5，9，41，109， ...
- (JKRArrayList<NSNumber *> *)sedgewickStepSequence {
    JKRArrayList<NSNumber *> *stepSequence = [JKRArrayList array];
    NSInteger k = 0, step = 0;
    while (true) {
        if (k % 2 == 0) {
            NSInteger pow0 = (NSInteger) pow(2, k >> 1);
            step = 1 + 9 * (pow0 * pow0 - pow0);
        } else {
            NSInteger pow1 = (NSInteger) pow(2, (k - 1) >> 1);
            NSInteger pow2 = (NSInteger) pow(2, (k + 1) >> 1);
            step = 1 + 8 * pow1 * pow2 - 6 * pow2;
        }
        if (step >= _array.count) {
            break;
        }
        [stepSequence insertObject:[NSNumber numberWithInteger:step] atIndex:0];
        k++;
    }
    return stepSequence;
}

@end
