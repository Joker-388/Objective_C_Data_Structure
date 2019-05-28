//
//  JKRTreeSet.m
//  TreeMapSet
//
//  Created by Lucky on 2019/5/18.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRTreeSet.h"

@interface JKRTreeSet ()

@property (nonatomic, strong) JKRTreeMap *map;

@end

@implementation JKRTreeSet

- (instancetype)initWithCompare:(jkrmap_compareBlock)compare {
    self = [super init];
    self.map = [[JKRTreeMap alloc] initWithCompare:compare];
    return self;
}

- (instancetype)init {
    self = [self initWithCompare:^int(id  _Nonnull e1, id  _Nonnull e2) {
        return [e1 compare:e2];
    }];
    return self;
}

- (NSUInteger)count {
    return self.map.count;
}

- (void)removeAllObjects {
    [self.map removeAllObjects];
}

- (void)removeObject:(id)object {
    [self.map removeObjectForKey:object];
}

- (void)addObject:(id)object {
    [self.map setObject:nil forKey:object];
}

- (BOOL)containsObject:(id)object {
    return [self.map containsKey:object];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    [self.map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, stop);
    }];
}

- (void)dealloc {
//    NSLog(@"<%@: %p> dealloc", self.className, self);
}

@end
