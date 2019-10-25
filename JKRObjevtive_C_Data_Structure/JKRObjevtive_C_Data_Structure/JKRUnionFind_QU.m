//
//  JKRUnionFind_QU.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU.h"

@implementation JKRUnionFind_QU

- (NSInteger)findValue:(NSInteger)value {
    [self rangeCheckWithValue:value];
    while (value != _parents[value].integerValue) {
        value = _parents[value].integerValue;
    }
    return value;
}

- (void)unionWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger p1 = [self findValue:value1];
    NSInteger p2 = [self findValue:value2];
    if (p1 == p2) {
        return;
    }
        
    _parents[p1] = [NSNumber numberWithInteger:p2];
}

@end
