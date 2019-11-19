//
//  JKRGraph.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRGraph<VertexType, EdgeWeightType> : NSObject

@end

@interface JKREdgeInfo<VertexType, EdgeWeightType> : NSObject

@property (nonatomic, strong) VertexType from;
@property (nonatomic, strong) VertexType to;
@property (nonatomic, strong) EdgeWeightType weight;

@end

@interface JKRGraph<VertexType, EdgeWeightType> (JKRGraph)

- (NSInteger)edgesSize;
- (NSInteger)vertricesSize;

- (void)addVertex:(VertexType)v;
- (void)addEdgeFrom:(VertexType)from to:(VertexType)to;
- (void)addEdgeFrom:(VertexType)from to:(VertexType)to weight:(nullable EdgeWeightType)weight;


- (void)removeVertex:(VertexType)v;
- (void)removeEdgeFrom:(VertexType)from to:(VertexType)to;


/// 广度优先搜索
/// @param v 起点
/// @param block 回调
- (void)bfsWithBegin:(VertexType)v block:(void(^)(VertexType v, BOOL *stop))block;

/// 深度优先搜索
/// @param v 起点
/// @param block 回调
- (void)dfsWithBegin:(VertexType)v block:(void(^)(VertexType v, BOOL *stop))block;

/// 拓扑排序
- (NSArray<VertexType> *)topologicalSort;


/// 最小生成树
- (NSArray<JKREdgeInfo *> *)minimumSpanningTree;

@end

NS_ASSUME_NONNULL_END
