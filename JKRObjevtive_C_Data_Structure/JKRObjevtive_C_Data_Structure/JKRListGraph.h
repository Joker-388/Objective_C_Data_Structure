//
//  JKRListGraph.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraph.h"

@class JKRVertex<VertexType, EdgeWeightType>;
@class JKREdge<VertexType, EdgeWeightType>;

NS_ASSUME_NONNULL_BEGIN

@interface JKRListGraph<VertexType, EdgeWeightType> : JKRGraph<VertexType, EdgeWeightType>

@property (nonatomic, strong) NSMutableDictionary<VertexType, JKRVertex<VertexType, EdgeWeightType> *> *vertices;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType, EdgeWeightType> *> *edges;
+ (instancetype)dirctedGraphWithDataArray:(NSArray<NSArray *> *)array;
+ (instancetype)undirctedGraphWithDataArray:(NSArray<NSArray *> *)array;

@end

@interface JKRVertex<VertexType, EdgeWeightType> : NSObject<NSCopying>

@property (nonatomic, strong) VertexType value;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType, EdgeWeightType> *> *inEdges;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType, EdgeWeightType> *> *outEdges;
- (instancetype) initWithValue:(VertexType) value;

@end

@interface JKREdge<VertexType, EdgeWeightType> : NSObject

@property (nonatomic, weak) JKRVertex<VertexType, EdgeWeightType> *from;
@property (nonatomic, weak) JKRVertex<VertexType, EdgeWeightType> *to;
@property (nonatomic, strong) EdgeWeightType weight;
- (instancetype)initWithFrom:(JKRVertex<VertexType, EdgeWeightType> *)from to:(JKRVertex<VertexType, EdgeWeightType> *)to;

@end

NS_ASSUME_NONNULL_END
