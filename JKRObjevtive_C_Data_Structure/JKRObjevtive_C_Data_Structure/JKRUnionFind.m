//
//  JKRUnionFind.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/24.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind.h"

@implementation JKRUnionFind

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    _parents = [JKRArray arrayWithLength:capacity];
    for (NSInteger i = 0; i < _parents.length; i++) {
        _parents[i] = [NSNumber numberWithInteger:i];
    }
    return self;
}

- (BOOL)isSameWithValue1:(NSInteger)value1 value2:(NSInteger)value2 {
    return [self findValue:value1] == [self findValue:value2];
}

- (void)rangeCheckWithValue:(NSInteger)value {
    if (value < 0 || value >= _parents.length) {
        NSAssert(NO, @"value is out of bounds");
    }
}

@end
