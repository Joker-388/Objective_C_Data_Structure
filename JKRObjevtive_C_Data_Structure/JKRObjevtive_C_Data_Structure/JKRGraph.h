//
//  JKRGraph.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRGraph<V, E> : NSObject

@end

@interface JKRGraph<V, E> (JKRGraph)

- (NSInteger)edgesSize;
- (NSInteger)vertricesSize;

- (void)addVertex:(V)v;
- (void)addEdgeFrom:(V)from to:(V)to;
- (void)addEdgeFrom:(V)from to:(V)to weight:(nullable E)weight;


- (void)removeVertex:(V)v;
- (void)removeEdgeFrom:(V)from to:(V)to;

- (void)bfsWithBegin:(V)v;

@end

NS_ASSUME_NONNULL_END
