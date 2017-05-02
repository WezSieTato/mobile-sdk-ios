//
//  NSDateUtils.m
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 19/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "NSDateUtils.h"

static NSDateFormatter *menigaDateFormatter;

@implementation NSDateUtils

+(BOOL)isDate:(NSDate*)firstDate equalToDateWithAllComponents:(NSDate *)secondDate {
    return [self isDate:firstDate equalToDate:secondDate withDateComponents:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond];
}

+(NSDateComponents*)allComponentsFromDate:(NSDate*)date {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond fromDate:date];
}

+(BOOL)isDate:(NSDate*)firstDate equalToDate:(NSDate *)secondDate withDateComponents:(NSCalendarUnit)components {
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components fromDate:firstDate toDate:secondDate options:0];
    
    if (dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == 0 && dateComponents.hour == 0 && dateComponents.minute == 0 && dateComponents.second == 0) {
        return YES;
    }
    
    
    return NO;
}

+(BOOL)isDate:(NSDate*)firstDate equalToDayMonthAndYear:(NSDate *)secondDate {
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components: NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit fromDate:firstDate toDate:secondDate options:0 ];
    
    if (dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == 0) {
        return YES;
    }
    
    return NO;
}

+(NSDateFormatter*)dateFormatter{
    
    if (menigaDateFormatter == nil) {
        menigaDateFormatter = [[NSDateFormatter alloc] init];
        [menigaDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH':'mm':'ss"];
    }
    
    return menigaDateFormatter;
}

@end
