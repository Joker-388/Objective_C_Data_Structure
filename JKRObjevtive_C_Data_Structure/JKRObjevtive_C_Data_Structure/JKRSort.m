//
//  JKRSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSort.h"

@implementation JKRSort

- (void)sortWithArray:(JKRArrayList *)array {
    if (!array || array.count < 2) {
        return;
    }
    
    _array = array;
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    [self sort];
    _time = CFAbsoluteTimeGetCurrent() - startTime;
}

- (NSComparisonResult)compare:(JKRSort *)otherSort {
    CFAbsoluteTime compareTime = _time - otherSort->_time;
    if (compareTime) return  compareTime > 0 ? NSOrderedDescending : NSOrderedAscending;
    NSInteger compareCompareCount = _compareCount - otherSort->_compareCount;
    if (compareCompareCount) return compareCompareCount > 0 ? NSOrderedDescending : NSOrderedAscending;
    NSInteger compareSwapCount = _swapCount - otherSort->_swapCount;
    if (compareSwapCount) return compareSwapCount > 0 ? NSOrderedDescending : NSOrderedAscending;
    return NSOrderedSame;
}

- (NSComparisonResult)compareWithIndex0:(NSUInteger)index0 index1:(NSUInteger)index1 {
    _compareCount++;
    return [_array[index0] compare:_array[index1]];
}

- (NSComparisonResult)compareWithObject0:(id)object0 object1:(id)object1 {
    _compareCount++;
    return [object0 compare:object1];
}

- (void)swapWithIndex0:(NSUInteger)index0 index1:(NSUInteger)index1 {
    _swapCount++;
    id tmp = _array[index0];
    _array[index0] = _array[index1];
    _array[index1] = tmp;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    NSString *timeString = [NSString stringWithFormat:@"\n耗时: %.3f s\n", _time];
    NSString *swapCountString = [NSString stringWithFormat:@"比较: %zd\n", _compareCount];
    NSString *compareCountString = [NSString stringWithFormat:@"交换: %zd\n", _swapCount];
    [string appendString:[NSString stringWithFormat:@"[%@, %p]: {", [self class], self]];
    [string appendString:timeString];
    [string appendString:swapCountString];
    [string appendString:compareCountString];
    [string appendString:@"}"];
    return string;
}

@end
