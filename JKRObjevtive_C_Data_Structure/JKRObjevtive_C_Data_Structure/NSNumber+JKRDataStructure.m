//
//  NSNumber+JKRDataStructure.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "NSNumber+JKRDataStructure.h"

@implementation NSNumber (JKRDataStructure)

+ (JKRArrayList<NSNumber *> *)jkr_randomArrayWithCount:(NSUInteger)count min:(NSInteger)min max:(NSInteger)max {
    JKRArrayList *array = [[JKRArrayList alloc] init];
    if (count == 0 || min > max) {
        return array;;
    }
    
    NSInteger delta = max - min + 1;
    for (NSUInteger i = 0; i < count; i++) {
        array[i] = [NSNumber numberWithInteger:(NSInteger)(arc4random() % delta) + min];
    }
    
    return array;
}

+ (JKRArrayList<NSNumber *> *)jkr_ascendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max {
    JKRArrayList *array = [[JKRArrayList alloc] initWithCapacity:max - min + 1];
    if (min > max) {
        return array;;
    }
    
    for (NSUInteger i = 0; i < max - min + 1; i++) {
        array[i] = [NSNumber numberWithInteger:min + i];
    }
    
    return array;
}

+ (JKRArrayList<NSNumber *> *)jkr_centerAsAscendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max disorderCount:(NSUInteger)disorderCount{
    JKRArrayList *array = [self jkr_ascendingOrderArrayWithMin:min max:max];
    if (disorderCount > array.count) {
        return array;
    }
    
    NSUInteger left = disorderCount >> 1;
    [self reverseArray:array begin:0 end:left];
    
    NSUInteger right = disorderCount - left;
    [self reverseArray:array begin:array.count - right end:array.count];
    
    return array;
}

+ (JKRArrayList<NSNumber *> *)jkr_tailAsAscendingOrderArrayWithMin:(NSInteger)min max:(NSInteger)max disorderCount:(NSUInteger)disorderCount {
    JKRArrayList *array = [self jkr_ascendingOrderArrayWithMin:min max:max];
    if (disorderCount > array.count) {
        return array;
    }
    
    [self reverseArray:array begin:0 end:disorderCount];
    return array;
}

+ (void)reverseArray:(JKRArrayList *)array begin:(NSUInteger)begin end:(NSUInteger)end {
    NSUInteger count = (end - begin) >> 1;
    NSUInteger sum = begin + end - 1;
    for (NSUInteger i = begin; i < begin + count; i++) {
        NSUInteger j = sum - i;
        NSNumber *tmp = array[i];
        array[i] = array[j];
        array[j] = tmp;
    }
}

+ (BOOL)jkr_isAscendingOrder:(JKRArrayList<NSNumber *> *)array {
    if (!array || array.count < 2) {
        return true;
    }
    
    for (NSUInteger i = 1; i < array.count; i++) {
        if ([array[i - 1] compare:array[i]] == NSOrderedDescending) {
            return false;
        }
    }
    return true;
}

@end
