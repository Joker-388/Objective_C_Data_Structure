//
//  JKRBinaryHeap.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseHeap.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger(^jkrbinaryheap_compareBlock)(id e1, id e2);

@interface JKRBinaryHeap : JKRBaseHeap {
@protected
    jkrbinaryheap_compareBlock _compareBlock;
}

/*
 二叉堆添加的元素必须具备可比较性
 1，通过初始化方法传入比较的代码块
 2，加入的对象是系统默认的带有compare:方法的类的实例，例如：NSNumber、NSString类的实例对象
 */
- (instancetype)initWithCompare:(nullable jkrbinaryheap_compareBlock)compare;

- (instancetype)initWithArray:(nullable NSArray *)array;

- (instancetype)initWithArray:(nullable NSArray *)array compare:(nullable jkrbinaryheap_compareBlock)compare;;

@end

NS_ASSUME_NONNULL_END
