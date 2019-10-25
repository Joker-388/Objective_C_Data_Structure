//
//  JKRUnionFind_QU_S.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU_S.h"

@implementation JKRUnionFind_QU_S

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super initWithCapacity:capacity];
    _sizes = [JKRArray arrayWithLength:capacity];
    for (NSInteger i = 0; i < _sizes.length; i++) {
        _sizes[i] = [NSNumber numberWithInteger:1];
    }
    return self;
}

- (void)unionWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger p1 = [self findValue:value1];
    NSInteger p2 = [self findValue:value2];
    if (p1 == p2) {
        return;
    }
    
    if (_sizes[p1].integerValue < _sizes[p2].integerValue) {
        _parents[p1] = [NSNumber numberWithInteger:p2];
        _sizes[p2] = [NSNumber numberWithInteger:_sizes[p2].integerValue + _sizes[p1].integerValue];
    } else {
        _parents[p2] = [NSNumber numberWithInteger:p1];
        _sizes[p1] = [NSNumber numberWithInteger:_sizes[p1].integerValue + _sizes[p2].integerValue];
    }
}

@end
