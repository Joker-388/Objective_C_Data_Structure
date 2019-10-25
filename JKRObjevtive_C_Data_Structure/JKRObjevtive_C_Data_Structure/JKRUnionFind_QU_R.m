//
//  JKRUnionFind_QU_R.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU_R.h"

@implementation JKRUnionFind_QU_R

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super initWithCapacity:capacity];
    _ranks = [JKRArray arrayWithLength:capacity];
    for (NSInteger i = 0; i < _ranks.length; i++) {
        _ranks[i] = [NSNumber numberWithInteger:1];
    }
    return self;
}

- (void)unionWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    NSInteger p1 = [self findValue:value1];
    NSInteger p2 = [self findValue:value2];
    if (p1 == p2) {
        return;
    }
    
    if (_ranks[p1].integerValue < _ranks[p2].integerValue) {
        _parents[p1] = [NSNumber numberWithInteger:p2];
    } else if (_ranks[p1].integerValue > _ranks[p2].integerValue) {
        _parents[p2] = [NSNumber numberWithInteger:p1];
    } else {
        _parents[p1] = [NSNumber numberWithInteger:p2];
        _ranks[p2] = [NSNumber numberWithInteger:_ranks[p2].integerValue + 1];
    }
}

@end
