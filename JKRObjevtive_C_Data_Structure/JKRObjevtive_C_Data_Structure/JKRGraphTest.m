//
//  JKRGraphTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraphTest.h"
#import "JKRListGraph.h"
#import "JKRGraphData.h"

@implementation JKRGraphTest

- (void)test {
//    JKRGraph *graph = [JKRListGraph new];
//    [graph addEdgeFrom:@"V1" to:@"V0" weight:@9];
//    [graph addEdgeFrom:@"V1" to:@"V2" weight:@3];
//    [graph addEdgeFrom:@"V2" to:@"V0" weight:@2];
//    [graph addEdgeFrom:@"V2" to:@"V3" weight:@5];
//    [graph addEdgeFrom:@"V3" to:@"V4" weight:@1];
//    [graph addEdgeFrom:@"V0" to:@"V4" weight:@6];
//
//
//    [graph removeEdgeFrom:@"V1" to:@"V0"];
//    [graph removeEdgeFrom:@"V1" to:@"V2"];
//    [graph removeEdgeFrom:@"V2" to:@"V0"];
//    [graph removeEdgeFrom:@"V2" to:@"V3"];
//    [graph removeEdgeFrom:@"V3" to:@"V4"];
//    [graph removeEdgeFrom:@"V0" to:@"V4"];
    
//    [graph removeVertex:@"V0"];
//    [graph removeVertex:@"V1"];
//    [graph removeVertex:@"V2"];
//    [graph removeVertex:@"V3"];
//    [graph removeVertex:@"V4"];
    
//    [graph addEdgeFrom:@"V0" to:@"V1"];
//    [graph addEdgeFrom:@"V1" to:@"V0"];
//
//    [graph addEdgeFrom:@"V0" to:@"V2"];
//    [graph addEdgeFrom:@"V2" to:@"V0"];
//
//    [graph addEdgeFrom:@"V0" to:@"V3"];
//    [graph addEdgeFrom:@"V3" to:@"V0"];
//
//    [graph addEdgeFrom:@"V1" to:@"V2"];
//    [graph addEdgeFrom:@"V2" to:@"V1"];
//
//    [graph addEdgeFrom:@"V2" to:@"V3"];
//    [graph addEdgeFrom:@"V3" to:@"V2"];
//
//    [graph bfsWithBegin:@"V1"];
    
//    NSLog(@"%@", graph);
//    [self testBfs];
//    [self testDfs];
//    [self testTop];
    [self testMst];
}

- (void)testBfs {
    JKRGraph *graph = [JKRListGraph undirctedGraphWithDataArray:[JKRGraphData BFS_01]];
    [graph bfsWithBegin:@"A" block:^(id  _Nonnull v, BOOL * _Nonnull stop) {
        if ([v isEqual:@"I"]) {
            *stop = YES;
        }
        NSLog(@"%@", v);
    }];
}

- (void)testDfs {
    JKRGraph *graph = [JKRListGraph dirctedGraphWithDataArray:[JKRGraphData DFS_02]];
    [graph dfsWithBegin:@"a" block:^(id  _Nonnull v, BOOL * _Nonnull stop) {
        if ([v isEqual:@"b"]) {
            *stop = YES;
        }
        NSLog(@"%@", v);
    }];
}

- (void)testTop {
    JKRGraph *graph = [JKRListGraph dirctedGraphWithDataArray:[JKRGraphData TOP_01]];
    NSLog(@"%@", [graph topologicalSort]);
}

- (void)testMst {
    JKRGraph *graph = [JKRListGraph undirctedGraphWithDataArray:[JKRGraphData MST_02]];
    NSLog(@"%@", [graph minimumSpanningTree]);
}

@end
