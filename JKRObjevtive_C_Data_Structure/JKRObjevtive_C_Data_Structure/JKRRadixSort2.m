//
//  JKRRadixSort2.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/18.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRRadixSort2.h"
#import "JKRArray.h"

@implementation JKRRadixSort2

- (void)sort {
    NSInteger max = _array[0].integerValue;
    
    for (NSInteger i = 1; i < _array.count; i++) {
        if (_array[i].integerValue > max) {
            max = _array[i].integerValue;
        }
    }
    
    JKRArray<JKRArray *> *buckets = [JKRArray arrayWithLength:10];
    for (NSInteger i = 0; i < buckets.length; i++) {
        buckets[i] = [JKRArray arrayWithLength:_array.count];
    }
    
    JKRArray<NSNumber *> *bucketsSizes = [JKRArray arrayWithLength:buckets.length];
    
    for (NSInteger divider = 1; divider <= max; divider *= 10) {
        for (NSInteger i = 0; i < _array.count; i++) {
            NSInteger no = _array[i].integerValue / divider % 10;
            buckets[no][bucketsSizes[no].integerValue] = _array[i];
            bucketsSizes[no] = [NSNumber numberWithInteger:bucketsSizes[no].integerValue + 1];
        }
        NSInteger index = 0;
        for (NSInteger i = 0; i < buckets.length; i++) {
            for (NSInteger j = 0; j < bucketsSizes[i].integerValue; j++) {
                _array[index++] = buckets[i][j];
            }
            bucketsSizes[i] = 0;
        }
    }
}

- (BOOL)isStable {
    return YES;
}

@end
