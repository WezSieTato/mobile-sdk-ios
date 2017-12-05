//
//  MNFTransactionSeries.m
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFTransactionSeries.h"
#import "MNFInternalImports.h"
#import "MNFTransaction.h"
#import "MNFTransactionSeriesStatistics.h"
#import "MNFTransactionSeriesValue.h"
#import "MNFTransactionSeriesFilter.h"
#import "MNFComment.h"
#import "MNFComment_Private.h"

@implementation MNFTransactionSeries

+(MNFJob *)fetchTransactionSeriesWithTransactionSeriesFilter:(MNFTransactionSeriesFilter *)seriesFilter withCompletion:(MNFTransactionSeriesCompletionHandler)completion {
    
    [completion copy];
    
    NSDictionary *transactionSeriesFilter = [MNFJsonAdapter JSONDictFromObject:seriesFilter option:kMNFAdapterOptionNoOption error:nil];
    
    NSString *path = [NSString stringWithFormat:@"%@/series",kMNFApiPathTransactions];
    
    NSMutableArray *modifiedSeriesSelector = [NSMutableArray array];
    
    for (MNFTransactionFilter *filter in seriesFilter.seriesSelectors) {
    
        NSDictionary *dict = @{@"filter":[MNFJsonAdapter JSONDictFromObject:filter option:kMNFAdapterOptionNoOption error:nil]};
        [modifiedSeriesSelector addObject:dict];
    
    }
    
    NSDictionary *jsonDict = @{@"transactionFilter":[MNFJsonAdapter JSONDictFromObject:seriesFilter.transactionFilter option:kMNFAdapterOptionNoOption error:nil],
                               @"options":@{@"timeResolution":[transactionSeriesFilter objectForKey:@"timeResolution"],
                                            @"overTime":[transactionSeriesFilter objectForKey:@"overTime"],
                                            @"includeTransactions":[transactionSeriesFilter objectForKey:@"includeTransactions"],
                                            @"includeTransactionIds":[transactionSeriesFilter objectForKey:@"includeTransactionIds"]},
                               @"seriesSelectors":[modifiedSeriesSelector copy]};
    
    NSData *jsonData = [MNFJsonAdapter JSONDataFromDictionary:jsonDict];
    
    __block MNFJob *job = [self apiRequestWithPath:path pathQuery:nil jsonBody:jsonData HTTPMethod:kMNFHTTPMethodPOST service:MNFServiceNameTransactions completion:^(MNFResponse * _Nullable response) {
        
        kObjectBlockDataDebugLog;
        
        if (response.error == nil) {
            
            if ([response.result isKindOfClass:[NSArray class]]) {
        
                NSArray *transactionSeries = [self initWithServerResults:response.result];
                
                for (MNFTransactionSeries *series in transactionSeries) {
                    
                    for (MNFTransaction *transaction in series.transactions) {
                        
                        for (MNFComment *comment in transaction.comments) {
                            comment.transactionId = transaction.identifier;
                        }
                    }
                }
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:transactionSeries error:nil];
            
            }
            else {
            
                [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error: [MNFErrorUtils errorForUnexpectedDataOfType:[response.result class] expected:[NSArray class]] ];
            
            }
        }
        else {
            
            [MNFObject executeOnMainThreadWithJob:job completion:completion parameter:nil error:response.error];
        
        }
    }];
    
    return job;
}

#pragma mark - Description 
-(NSString*)description {
    return [NSString stringWithFormat:@"Transaction series %@ timeResolution: %@, statistics: %@, values: %@, transactions: %@, transactionIds: %@",[super description],self.timeResolution,self.statistics,self.values,self.transactions,self.transactionIds];
}

#pragma mark - Json Adapter Delegate

-(NSSet *)propertiesToIgnoreJsonDeserialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSSet *)propertiesToIgnoreJsonSerialization {
    return [NSSet setWithObjects:@"objectstate", nil];
}

-(NSDictionary*)subclassedProperties {
    return @{
             @"transactions": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass: [MNFTransaction class] option: kMNFAdapterOptionNoOption],
             @"statistics": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTransactionSeriesStatistics class] option:kMNFAdapterOptionNoOption],
             @"values": [MNFJsonAdapterSubclassedProperty subclassedPropertyWithClass:[MNFTransactionSeriesValue class] option:kMNFAdapterOptionNoOption]
             };
}

@end
