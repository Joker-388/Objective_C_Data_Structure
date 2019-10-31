//
//  UnionFindTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "UnionFindTest.h"
#import "JKRUnionFind_QF.h"
#import "JKRUnionFind_QU.h"
#import "JKRUnionFind_QU_S.h"
#import "JKRUnionFind_QU_R.h"
#import "JKRUnionFind_QU_R_PC.h"
#import "JKRUnionFind_QU_R_PS.h"
#import "JKRUnionFind_QU_R_PH.h"

@implementation UnionFindTest

- (void)runTest {
    [self testWithUnionFind:[[JKRUnionFind_QF alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU_S alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU_R alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU_R_PC alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU_R_PS alloc] initWithCapacity:14]];
    [self testWithUnionFind:[[JKRUnionFind_QU_R_PH alloc] initWithCapacity:14]];
}


/// 测试
/// @param uf 测试对象实例
- (void)testWithUnionFind:(JKRUnionFind *)uf {
    [uf unionWithValue1:0 value2:1];
    [uf unionWithValue1:0 value2:3];
    [uf unionWithValue1:0 value2:4];
    [uf unionWithValue1:2 value2:3];
    [uf unionWithValue1:2 value2:5];
    
    [uf unionWithValue1:6 value2:7];
    
    [uf unionWithValue1:8 value2:10];
    [uf unionWithValue1:9 value2:10];
    [uf unionWithValue1:9 value2:11];
    
    NSAssert(![uf isSameWithValue1:2 value2:7], @"");
    
    [uf unionWithValue1:4 value2:6];
    
    NSAssert([uf isSameWithValue1:2 value2:7], @"");
}

@end
