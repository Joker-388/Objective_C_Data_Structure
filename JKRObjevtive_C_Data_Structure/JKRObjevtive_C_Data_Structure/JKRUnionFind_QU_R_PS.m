//
//  JKRUnionFind_QU_R_PS.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU_R_PS.h"

@implementation JKRUnionFind_QU_R_PS

- (NSInteger)findValue:(NSInteger)value {
    [self rangeCheckWithValue:value];
    while (value != _parents[value].integerValue) {
        NSInteger p = _parents[value].integerValue;
        _parents[value] = _parents[_parents[value].integerValue];
        value = p;
    }
    return value;
}

@end
