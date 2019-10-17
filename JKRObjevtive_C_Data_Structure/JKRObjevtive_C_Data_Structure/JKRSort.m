//
//  JKRSort.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSort.h"
#import "JKRSortModel.h"

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

- (BOOL)isStable {
    JKRArrayList<JKRSortModel *> *models = [JKRArrayList arrayWithCapacity:20];
    for (NSInteger i = 0; i < 20; i++) {
        JKRSortModel *model = [[JKRSortModel alloc] init];
        model.score = i * 10;
        model.age = 10;
        models[i] = model;
    }
    [self sortWithArray:models];
    for (NSInteger i = 1; i < models.count; i++) {
        NSInteger score = models[i].score;
        NSInteger preScore = models[i - 1].score;
        if (score != preScore + 10) {
            return false;
        }
    }
    return true;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    NSString *timeString = [NSString stringWithFormat:@"\n耗时: %.3f s\n", _time];
    NSString *stableString = [NSString stringWithFormat:@"稳定性: %@\n", [self isStable] ? @"是":@"否"];
    NSString *swapCountString = [NSString stringWithFormat:@"比较: %zd\n", _compareCount];
    NSString *compareCountString = [NSString stringWithFormat:@"交换: %zd\n", _swapCount];
    [string appendString:[NSString stringWithFormat:@"[%@, %p]: {", [self class], self]];
    [string appendString:timeString];
    [string appendString:stableString];
    [string appendString:swapCountString];
    [string appendString:compareCountString];
    [string appendString:@"}"];
    return string;
}

@end
