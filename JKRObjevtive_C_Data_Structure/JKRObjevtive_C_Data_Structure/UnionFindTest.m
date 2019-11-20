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
#import "JKRUnionFind.h"

@implementation UnionFindTest

- (void)test {
//    [self testWithUnionFind:[[JKRUnionFind_QF alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU_S alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU_R alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU_R_PC alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU_R_PS alloc] initWithCapacity:14]];
//    [self testWithUnionFind:[[JKRUnionFind_QU_R_PH alloc] initWithCapacity:14]];
    
    JKRUnionFind *uf = [[JKRUnionFind alloc] init];
    for (NSInteger i = 0; i < 12; i++) {
        [uf makeSetWithValue:[NSNumber numberWithInteger:i]];
    }
    
    NSAssert(![uf isSameWithValue1:@0 value2:@1], @"检查到错误");
    
    [uf unionWithValue1:@0 value2:@1];
    // 0-1
    
    NSAssert([uf isSameWithValue1:@0 value2:@1], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@3], @"检查到错误");
    
    [uf unionWithValue1:@0 value2:@3];
    // 0-1-3
    
    NSAssert([uf isSameWithValue1:@0 value2:@3], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@3 value2:@4], @"检查到错误");
    
    [uf unionWithValue1:@0 value2:@4];
    // 0-1-3-4
    
    NSAssert([uf isSameWithValue1:@3 value2:@4], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@2], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@5], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@3 value2:@5], @"检查到错误");
    
    [uf unionWithValue1:@2 value2:@3];
    [uf unionWithValue1:@2 value2:@5];
    // 0-1-2-3-4-5 6 7 8 9 10 11
    
    NSAssert([uf isSameWithValue1:@0 value2:@2], @"检查到错误");
    NSAssert([uf isSameWithValue1:@0 value2:@5], @"检查到错误");
    NSAssert([uf isSameWithValue1:@3 value2:@5], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@6], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@6 value2:@7], @"检查到错误");
    
    [uf unionWithValue1:@6 value2:@7];
    // 0-1-2-3-4-5 6-7 8 9 10 11
    
    NSAssert([uf isSameWithValue1:@6 value2:@7], @"检查到错误");
    
    NSAssert(![uf isSameWithValue1:@0 value2:@8], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@9], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@9 value2:@11], @"检查到错误");
    
    [uf unionWithValue1:@8 value2:@10];
    [uf unionWithValue1:@9 value2:@10];
    // 0-1-2-3-4-5 6-7 8-9-10 11
    
    NSAssert([uf isSameWithValue1:@9 value2:@10], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@9], @"检查到错误");
    
    [uf unionWithValue1:@9 value2:@11];
    // 0-1-2-3-4-5 6-7 8-9-10-11
    
    NSAssert([uf isSameWithValue1:@8 value2:@11], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@0 value2:@11], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@2 value2:@7], @"检查到错误");
    
    [uf unionWithValue1:@4 value2:@6];
    // 0-1-2-3-4-5-6-7 8-9-10-11
    
    NSAssert([uf isSameWithValue1:@2 value2:@7], @"检查到错误");
    NSAssert(![uf isSameWithValue1:@2 value2:@11], @"检查到错误");
    
    [uf unionWithValue1:@3 value2:@9];
    // 0-1-2-3-4-5-6-7-8-9-10-11
    
    NSAssert([uf isSameWithValue1:@2 value2:@11], @"检查到错误");
}


/// 测试
/// @param uf 测试对象实例
- (void)testWithUnionFind:(JKRUnionFindBase *)uf {
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
