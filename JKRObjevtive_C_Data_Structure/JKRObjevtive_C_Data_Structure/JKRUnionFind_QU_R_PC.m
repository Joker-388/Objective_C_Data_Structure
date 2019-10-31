//
//  JKRUnionFind_QU_R_PC.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU_R_PC.h"

 @implementation JKRUnionFind_QU_R_PC

- (NSInteger)findValue:(NSInteger)value {
    [self rangeCheckWithValue:value];
    if (_parents[value].integerValue != value) {
        _parents[value] = [NSNumber numberWithInteger:[self findValue:_parents[value].integerValue]];
    }
    return _parents[value].integerValue;
}

@end
