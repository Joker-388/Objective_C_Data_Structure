//
//  JKRUnionFind_QF.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QF.h"

@implementation JKRUnionFind_QF

- (NSInteger)findValue:(NSInteger)value {
    [self rangeCheckWithValue:value];
    return _parents[value].integerValue;
}

- (void)unionWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger p1 = [self findValue:value1];
    NSInteger p2 = [self findValue:value2];
    if (p1 == p2) {
        return;
    }
    
    for (NSInteger i = 0; i < _parents.length; i++) {
        if (_parents[i].integerValue == p1) {
            _parents[i] = [NSNumber numberWithInteger:p2];
        }
    }
}

@end
