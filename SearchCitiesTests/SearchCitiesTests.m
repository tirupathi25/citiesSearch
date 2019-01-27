//
//  SearchCitiesTests.m
//  SearchCitiesTests
//
//  Created by Tirupathi Mandali on 1/26/19.
//  Copyright © 2019 Tirupathi Mandali. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SearchCitiesTests : XCTestCase

@end

@implementation SearchCitiesTests
{
    NSArray *testCityData;
}
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
//test mock data
    testCityData = @[@{@"name":@"Alabama",@"country":@"US"},
                     @{@"name":@"Albuquerque",@"country":@"US"},
                     @{@"name":@"Anaheim",@"country":@"US"},
                     @{@"name":@"Arizona",@"country":@"US"},
                     @{@"name":@"Sydney",@"country":@"AU"}
                     ];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
//search criteria logic
-(BOOL )searchedDataWithKay:(NSString *)keyword{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name BEGINSWITH[c] %@) OR (country BEGINSWITH[c] %@)", keyword,keyword];
    
    NSArray *result = [testCityData filteredArrayUsingPredicate:predicate];
    return result !=0 ? YES : NO;
}
-(void)testSearchCitywithKeyword_A{
    
//    NSLog(@"%@",[self searchedDataWithKay:@"A"]);
    
    
    BOOL success = [self searchedDataWithKay:@"A"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should print all cities Prefix with A and even country prefix A"];
    XCTAssertTrue(success,@"success");
    
    if (success)
    {
        [expectation fulfill];
    }
    
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}
-(void)testSearchCitywithKeyword_S{
    
//    NSLog(@"%@",[self searchedDataWithKay:@"S"]);
    
    BOOL success = [self searchedDataWithKay:@"S"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should print all cities Prefix with S and even country prefix S"];
    XCTAssertTrue(success,@"success");
    
    if (success)
    {
        [expectation fulfill];
    }
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}
-(void)testSearchCitywithKeyword_Al{
    
//    NSLog(@"%@",[self searchedDataWithKay:@"Al"]);
    
    BOOL success = [self searchedDataWithKay:@"Al"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should print all cities Prefix with Al and even country prefix Al"];
    XCTAssertTrue(success,@"success");
    
    if (success)
    {
        [expectation fulfill];
    }
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}
-(void)testSearchCitywithKeyword_Alb{
    
//    NSLog(@"%@",[self searchedDataWithKay:@"Alb"]);
    
    BOOL success = [self searchedDataWithKay:@"Alb"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should print all cities Prefix with Alb and even country prefix Alb"];
    
    XCTAssertTrue(success,@"success");
    
    if (success)
    {
        [expectation fulfill];
    }
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
}
-(void)testSearchCitywithIvalidKeyword_Klm{
    
    
//    NSLog(@"%@",[self searchedDataWithKay:@"Klm"]);
    
    BOOL success = [self searchedDataWithKay:@"Klm"];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should print all cities Prefix with Klm and even country prefix Klm "];
    XCTAssertTrue(success,@"success");
    
    if (success)
    {
        [expectation fulfill];
    }
    
    [self waitForExpectationsWithTimeout: 30 handler:^(NSError *error) {
        if (error != nil) {
            XCTFail(@"timeout");
        }
    }];
    
}
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
