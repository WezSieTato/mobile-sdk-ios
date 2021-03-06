//
//  MNFRealmAccount.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 12/07/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFRealmAccount.h"
#import "MNFJsonAdapter.h"

@interface MNFRealmAccount () <MNFJsonAdapterDelegate>

@end

@implementation MNFRealmAccount

#pragma mark - SDK Serialization

-(NSDictionary *)jsonKeysMapToProperties {
    return @{ @"identifier" : @"id" };
}

-(NSDictionary *)propertyKeysMapToJson {
    return @{ @"identifier" : @"id" };
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    
    return [NSSet setWithObjects:@"objectstate", @"mutableProperties", @"keyValueStore", @"deleted", @"isNew", @"dirty", @"identifier", nil];
}

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    
    return [NSSet setWithObjects:@"objectstate", @"mutableProperties", @"keyValueStore", @"deleted", @"isNew", @"dirty", @"identifier", nil];
}

@end
