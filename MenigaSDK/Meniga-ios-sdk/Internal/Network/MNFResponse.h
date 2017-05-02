//
//  MenigaResponse.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MNFResponse : NSObject
/**
 @abstract The HTTP status code.
 */
@property (nonatomic,strong,readonly, nullable) NSError *error;
/**
 @abstract The HTTP status code.
 */
@property (nonatomic,assign,readonly) NSInteger statusCode;
/**
 @abstract The result of the request.
 */
@property (nonatomic,strong,readonly, nullable) id result;

/**
 @abstract The dictionary or array of objects that comes from the meta tag which has additional information about the result data.
 */
@property (nonatomic, strong, readonly, nullable) id metaData;

/**
 @abstract The raw data from the network request.
 */
@property (nonatomic, strong, readonly, nullable) NSData *rawData;

/**
 @abstract
 */
@property (nonatomic,strong,readonly) NSDictionary *allHeaderFields;

+ (instancetype)responseWithData:(nullable NSData *)data error:(nullable NSError *)error statusCode:(NSInteger)statusCode headerFields:(nullable NSDictionary*)allHeaderFields;

@end

NS_ASSUME_NONNULL_END
