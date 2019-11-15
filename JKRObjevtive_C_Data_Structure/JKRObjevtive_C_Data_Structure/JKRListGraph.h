//
//  JKRListGraph.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraph.h"
#import "JKRHashMap_RedBlackTree.h"
#import "JKRHashSet.h"
#import "JKRArrayList.h"

@class JKRVertex<V, E>;
@class JKREdge<V, E>;

NS_ASSUME_NONNULL_BEGIN

@interface JKRListGraph<V, E> : JKRGraph<V, E>

@property (nonatomic, strong) JKRHashMap_RedBlackTree<V, JKRVertex<V, E> *> *vertices;
@property (nonatomic, strong) JKRHashSet<JKREdge<V, E> *> *edges;
+ (instancetype)dirctedGraphWithDataArray:(NSArray<NSArray *> *)array;
+ (instancetype)undirctedGraphWithDataArray:(NSArray<NSArray *> *)array;

@end

@interface JKRVertex<V, E> : NSObject

@property (nonatomic, strong) V value;
@property (nonatomic, strong) JKRHashSet<JKREdge<V, E> *> *inEdges;
@property (nonatomic, strong) JKRHashSet<JKREdge<V, E> *> *outEdges;
- (instancetype) initWithValue:(V) value;

@end

@interface JKREdge<V, E> : NSObject

@property (nonatomic, weak) JKRVertex<V, E> *from;
@property (nonatomic, weak) JKRVertex<V, E> *to;
@property (nonatomic, strong) id weight;
- (instancetype)initWithFrom:(JKRVertex<V, E> *)from to:(JKRVertex<V, E> *)to;

@end

NS_ASSUME_NONNULL_END
