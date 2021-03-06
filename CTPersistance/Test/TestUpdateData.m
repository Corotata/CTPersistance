//
//  TestUpdateDataCenter.m
//  CTPersistance
//
//  Created by casa on 15/10/6.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "TestUpdateData.h"
#import "CTPersistance.h"
#import "TestTable.h"
#import <UIKit/UIKit.h>

@implementation TestUpdateData

- (void)test
{
    TestTable *table = [[TestTable alloc] init];
    NSError *error = nil;
    
    /* test 3001 */
    TestRecord *record = [[TestRecord alloc] init];
    record.age = @(1024);
    record.name = @"casa";
    record = (TestRecord *)[table insertRecord:record error:&error];
    error = nil;
    record.age = @(2048);
    [table updateRecord:record error:&error];
    error = nil;
    record = (TestRecord *)[table findWithPrimaryKey:record.primaryKey error:&error];
    if ([record.age integerValue] == 2048) {
        NSLog(@"3001 success");
    } else {
        NSException *exception = [[NSException alloc] init];
        @throw exception;
    }
    
    /* 3002 */
    NSDictionary *keyvalueList = @{@"migration1_0":@"this is migration"};
    NSString *whereCondition = @":primaryKey > 0";
    NSString *primaryKey = [table primaryKeyName];
    NSDictionary *whereConditionParams = NSDictionaryOfVariableBindings(primaryKey);
    [table updateKeyValueList:keyvalueList whereCondition:whereCondition whereConditionParams:whereConditionParams error:&error];
}

@end
