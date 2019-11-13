//
//  JKRGraphTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraphTest.h"
#import "JKRListGraph.h"

@implementation JKRGraphTest

- (void)test {
    JKRGraph *graph = [JKRListGraph new];
    [graph addEdgeFrom:@"V1" to:@"V0" weight:@9];
    [graph addEdgeFrom:@"V1" to:@"V2" weight:@3];
    [graph addEdgeFrom:@"V2" to:@"V0" weight:@2];
    [graph addEdgeFrom:@"V2" to:@"V3" weight:@5];
    [graph addEdgeFrom:@"V3" to:@"V4" weight:@1];
    [graph addEdgeFrom:@"V0" to:@"V4" weight:@6];
    
    NSLog(@"%@", graph);
}

@end
