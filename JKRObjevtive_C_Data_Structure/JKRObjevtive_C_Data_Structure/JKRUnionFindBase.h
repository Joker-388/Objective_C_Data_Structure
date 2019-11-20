//
//  JKRUnionFind.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/24.
//  Copyright © 2019 Joker. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "JKRArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRUnionFindBase : NSObject {
@protected
    JKRArray<NSNumber *> *_parents;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity;
- (BOOL)isSameWithValue1:(NSInteger)value1 value2:(NSInteger)value2;
- (void)rangeCheckWithValue:(NSInteger)value;

@end

@interface JKRUnionFindBase (JKRUnionFind)

- (NSInteger)findValue:(NSInteger)value;
- (void)unionWithValue1:(NSInteger)value1 value2:(NSInteger)value2;

@end

NS_ASSUME_NONNULL_END
