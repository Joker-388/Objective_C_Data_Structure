//
//  JKRListGraph.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRListGraph.h"


@interface JKRListGraph ()



@end

@implementation JKRListGraph

- (NSInteger)edgesSize {
    return self.edges.count;
}

- (NSInteger)vertricesSize {
    return self.vertices.count;
}

- (void)addVertex:(id)v {
    if ([self.vertices containsKey:v]) {
        return;
    }
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
    
}

- (void)removeEdgeFrom:(id)from to:(id)to {
    
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
    [str appendString:[NSString stringWithFormat:@"<%@: %p>: \n", self.className, self]];
    [str appendString:[NSString stringWithFormat:@"----- Vertices: %zd -----\n", self.vertices.count]];
    [self.vertices enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"%@\n", obj]];
    }];
    [str appendString:[NSString stringWithFormat:@"----- Edges: %zd -----\n", self.edges.count]];
    [self.edges enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendString:[NSString stringWithFormat:@"%@\n", obj]];
    }];
    return str;
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