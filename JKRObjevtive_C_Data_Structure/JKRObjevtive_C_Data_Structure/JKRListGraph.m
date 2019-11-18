//
//  JKRListGraph.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRListGraph.h"
#import "JKRQueue.h"
#import "JKRStack.h"

@implementation JKRListGraph

+ (instancetype)dirctedGraphWithDataArray:(NSArray<NSArray *> *)array {
    JKRListGraph *graph = [JKRListGraph new];
    for (NSArray *edge in array) {
        if (edge.count == 1) {
            [graph addVertex:edge[0]];
        } else if (edge.count == 2) {
            [graph addEdgeFrom:edge[0] to:edge[1]];
        } else if (edge.count == 3) {
            [graph addEdgeFrom:edge[0] to:edge[1] weight:edge[2]];
        }
    }
    return graph;
}

+ (instancetype)undirctedGraphWithDataArray:(NSArray<NSArray *> *)array {
    JKRListGraph *graph = [JKRListGraph new];
    for (NSArray *edge in array) {
        if (edge.count == 1) {
            [graph addVertex:edge[0]];
        } else if (edge.count == 2) {
            [graph addEdgeFrom:edge[0] to:edge[1]];
            [graph addEdgeFrom:edge[1] to:edge[0]];
        } else if (edge.count == 3) {
            [graph addEdgeFrom:edge[0] to:edge[1] weight:edge[2]];
            [graph addEdgeFrom:edge[1] to:edge[0] weight:edge[2]];
        }
    }
    return graph;
}

- (NSInteger)edgesSize {
    return self.edges.count;
}

- (NSInteger)vertricesSize {
    return self.vertices.count;
}

- (void)addVertex:(id)v {
    if ([self.vertices containsKey:v]) return;
    [self.vertices setObject:[[JKRVertex alloc] initWithValue:v]  forKey:v];
}

- (void)addEdgeFrom:(id)from to:(id)to {
    [self addEdgeFrom:from to:to weight:nil];
}

- (void)addEdgeFrom:(id)from to:(id)to weight:(id)weight {
    JKRVertex *fromVertex = self.vertices[from];
    if (!fromVertex) {
        fromVertex = [[JKRVertex alloc] initWithValue:from];
        [self.vertices setObject:fromVertex forKey:from];
    }
    
    JKRVertex *toVertex = self.vertices[to];
    if (!toVertex) {
        toVertex = [[JKRVertex alloc] initWithValue:to];
        [self.vertices setObject:toVertex forKey:to];
    }
    
    JKREdge *edge = [[JKREdge alloc] initWithFrom:fromVertex to:toVertex];
    edge.weight = weight;
    
    [fromVertex.outEdges removeObject:edge];
    [toVertex.inEdges removeObject:edge];
    [self.edges removeObject:edge];
    
    [fromVertex.outEdges addObject:edge];
    [toVertex.inEdges addObject:edge];
    [self.edges addObject:edge];
}

- (void)removeVertex:(id)v {
    JKRVertex *vertex = self.vertices[v];
    if (!vertex) return;
    JKRArrayList<JKREdge *> *removeEdges = [JKRArrayList array];
    [vertex.outEdges enumerateObjectsUsingBlock:^(JKREdge *  _Nonnull obj, BOOL * _Nonnull stop) {
        [removeEdges addObject:obj];
    }];
    [vertex.inEdges enumerateObjectsUsingBlock:^(JKREdge *  _Nonnull obj, BOOL * _Nonnull stop) {
        [removeEdges addObject:obj];
    }];
    [removeEdges enumerateObjectsUsingBlock:^(JKREdge * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeEdgeFrom:obj.from.value to:obj.to.value];
    }];
    [self.vertices removeObjectForKey:v];
}

- (void)removeEdgeFrom:(id)from to:(id)to {
    JKRVertex *fromVertex = self.vertices[from];
    if (!fromVertex) return;
    JKRVertex *toVertex = self.vertices[to];
    if (!toVertex) return;
    JKREdge *edge = [[JKREdge alloc] initWithFrom:fromVertex to:toVertex];
    if ([fromVertex.outEdges containsObject:edge]) {
        [fromVertex.outEdges removeObject:edge];
        [toVertex.inEdges removeObject:edge];
        [self.edges removeObject:edge];
    }
}

- (JKRHashMap_RedBlackTree *)vertices {
    if (!_vertices) {
        _vertices = [JKRHashMap_RedBlackTree new];
    }
    return _vertices;
}

- (JKRHashSet *)edges {
    if (!_edges) {
        _edges = [JKRHashSet new];
    }
    return _edges;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"\n==== PrintGraph  ====\n"];
    [str appendString:[NSString stringWithFormat:@"<%@: %p>: \n", self.className, self]];
    [str appendString:[NSString stringWithFormat:@"----- Vertices: %zd -----\n", self.vertricesSize]];
    [self.vertices enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"%@\n", obj]];
    }];
    [str appendString:[NSString stringWithFormat:@"----- Edges: %zd -----\n", self.edgesSize]];
    [self.edges enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"%@\n", obj]];
    }];
    [str appendString:@"=====================\n"];
    return str;
}

- (void)bfsWithBegin:(id)v block:(nonnull void (^)(id _Nonnull, BOOL * _Nonnull))block{
    JKRVertex *vertex = self.vertices[v];
    if (!vertex) return;
    
    JKRHashSet<JKRVertex *> *visitedVertices = [JKRHashSet new];
    
    JKRQueue<JKRVertex *> *queue = [JKRQueue new];
    [queue enQueue:vertex];
    [visitedVertices addObject:vertex];
    
    __block BOOL stop = NO;
    
    while (queue.count) {
        JKRVertex *vertex = [queue deQueue];
        block(vertex.value, &stop);
        if (stop) return;

        [vertex.outEdges enumerateObjectsUsingBlock:^(JKREdge *  _Nonnull obj, BOOL * _Nonnull s) {
            if (![visitedVertices containsObject:obj.to]) {
                [queue enQueue:obj.to];
                [visitedVertices addObject:obj.to];
            }
        }];
    }
}

- (void)dfsWithBegin:(id)v block:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    JKRVertex *vertex = self.vertices[v];
    if (!vertex) return;
    JKRHashSet<JKRVertex *> *visitedVertices = [JKRHashSet new];
    __block BOOL stop = NO;
    
//    [self dfsTraversal:vertex visitedVertices:visitedVertices block:block];
    
    JKRStack<JKRVertex *> *stack = [JKRStack new];
    [stack push:vertex];
    [visitedVertices addObject:vertex];
    block(vertex.value, &stop);
    if (stop) return;
    
    while (stack.count) {
        JKRVertex *v = stack.pop;

        [v.outEdges enumerateObjectsUsingBlock:^(JKREdge *  _Nonnull obj, BOOL * _Nonnull s) {
            if (stop) {
                *s = YES;
                return;
            }
            if (![visitedVertices containsObject:obj.to]) {
                [stack push:obj.from];
                [stack push:obj.to];
                [visitedVertices addObject:obj.to];
                block(obj.to.value, &stop);
                *s = YES;
            }
        }];
    }
}

//- (void)dfsTraversal:(JKRVertex *)vertex visitedVertices:(JKRHashSet<JKRVertex *> *)visitedVertices block:(void (^)(id _Nonnull))block {
//    block(vertex.value);
//    [visitedVertices addObject:vertex];
//    [vertex.outEdges enumerateObjectsUsingBlock:^(JKREdge *  _Nonnull obj, BOOL * _Nonnull s) {
//        if (![visitedVertices containsObject:obj.to]) {
//            [self dfsTraversal:obj.to visitedVertices:visitedVertices block:block];
//        }
//    }];
//}

- (NSArray *)topologicalSort {
    
    
    return nil;
}

@end

@implementation JKRVertex

- (instancetype)initWithValue:(id)value {
    self = [super init];
    self.value = value;
    return self;
}

- (JKRHashSet *)inEdges {
    if (!_inEdges) {
        _inEdges = [JKRHashSet new];
    }
    return _inEdges;
}

- (JKRHashSet *)outEdges {
    if (!_outEdges) {
        _outEdges = [JKRHashSet new];
    }
    return _outEdges;
}

- (BOOL)isEqual:(JKRVertex *)object {
    return [object.value isEqual:self.value];
}

- (NSUInteger)hash {
    return self.value ? [self.value hash] : 0;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"<%@: %p>: %@ {\n", self.className, self, self.value]];
    [str appendString:[NSString stringWithFormat:@"   InEdges: [\n"]];
    [self.inEdges enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"      %@\n", obj]];
    }];
    [str appendString:@"   ]\n"];
    [str appendString:[NSString stringWithFormat:@"   OutEdges: [\n"]];
    [self.outEdges enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"      %@\n", obj]];
    }];
    [str appendString:@"   ]\n"];
    [str appendString:@"}"];
    return str;
}

@end

@implementation JKREdge

- (instancetype)initWithFrom:(JKRVertex *)from to:(JKRVertex *)to {
    self = [super init];
    self.from = from;
    self.to = to;
    return self;
}

- (BOOL)isEqual:(JKREdge *)object {
    return [object.from isEqual:self.from] && [object.to isEqual:self.to];
}

- (NSUInteger)hash {
    NSNumber *fromCode = [NSNumber numberWithInteger:self.from.hash];
    NSNumber *toCode = [NSNumber numberWithInteger:self.to.hash];
    return fromCode.hash + toCode.hash;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"<%@: %p>: [From: %@] -- [To: %@] == [Weight: %@]", self.className, self, self.from.value, self.to.value, self.weight]];
    return str;
}

@end
