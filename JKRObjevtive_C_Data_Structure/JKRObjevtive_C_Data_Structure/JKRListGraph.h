//
//  JKRListGraph.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraph.h"
#import "JKRDSPotocol.h"

@class JKRVertex<VertexType>;
@class JKREdge<VertexType>;

NS_ASSUME_NONNULL_BEGIN

@interface JKRListGraph<VertexType> : JKRGraph<VertexType>

@property (nonatomic, strong) NSMutableDictionary<VertexType, JKRVertex<VertexType> *> *vertices;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType> *> *edges;
+ (instancetype)dirctedGraphWithDataArray:(NSArray<NSArray *> *)array;
+ (instancetype)undirctedGraphWithDataArray:(NSArray<NSArray *> *)array;

@end

@interface JKRVertex<VertexType> : NSObject<NSCopying>

@property (nonatomic, strong) VertexType value;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType> *> *inEdges;
@property (nonatomic, strong) NSMutableSet<JKREdge<VertexType> *> *outEdges;
- (instancetype) initWithValue:(VertexType) value;

@end

@interface JKREdge<VertexType> : NSObject<JKRDSCompare, NSCopying>

@property (nonatomic, weak) JKRVertex<VertexType> *from;
@property (nonatomic, weak) JKRVertex<VertexType> *to;
@property (nonatomic, strong) NSNumber * weight;
- (instancetype)initWithFrom:(JKRVertex<VertexType> *)from to:(JKRVertex<VertexType> *)to;

@end

NS_ASSUME_NONNULL_END
