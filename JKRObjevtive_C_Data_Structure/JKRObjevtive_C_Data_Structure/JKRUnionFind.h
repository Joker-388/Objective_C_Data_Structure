//
//  JKRUnionFind.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/20.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class JKRUnionNode<ObjectType>;


NS_ASSUME_NONNULL_BEGIN

@interface JKRUnionFind<ObjectType: id<NSCopying>> : NSObject

- (void)makeSetWithValue:(ObjectType)value;
- (ObjectType)findWithValue:(ObjectType)value;
- (void)unionWithValue1:(ObjectType)value1 value2:(ObjectType)value2;
- (BOOL)isSameWithValue1:(ObjectType)value1 value2:(ObjectType)value2;

@end

NS_ASSUME_NONNULL_END
