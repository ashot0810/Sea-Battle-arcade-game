//
//  UnitTestsForDataSourceForSavedItemsViewController.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForDataSourceForSavedItemsViewController: XCTestCase {
    
    var dataSourceForSavedItems: DataSourceForSavedItemsViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSourceForSavedItems = DataSourceForSavedItemsViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSourceForSavedItems = nil
    }

    func testExampleForProvidingMethods()  {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        let promise = expectation(description: "dataGetted")
       
        //When
        let providedDataForMaps = DataSavingManager.loadSavedMaps()
        let providedDataForShipsRotatedLeft = DataSavingManager.loadSavedShipsLeftRotated()
        let providedDataForShipsRotatedRight = DataSavingManager.loadSavedShipsRightRotated()
        let providedDataAboutWaterMarks = DataSavingManager.loadWaterMarksData()
        let mapImageData = DataSavingManager.loadMapsImage()
        let addedShipsCount = DataSavingManager.loadShipsCountData()
        dataSourceForSavedItems.getData()
        promise.fulfill()
        
        //Then
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(dataSourceForSavedItems.provideData().0, providedDataForMaps)
        XCTAssertEqual(dataSourceForSavedItems.provideData().1, providedDataForShipsRotatedLeft)
        XCTAssertEqual(dataSourceForSavedItems.provideData().2, providedDataForShipsRotatedRight)
        XCTAssertEqual(dataSourceForSavedItems.provideData().3, providedDataAboutWaterMarks)
        XCTAssertEqual(dataSourceForSavedItems.provideData().4, mapImageData)
        XCTAssertEqual(dataSourceForSavedItems.provideData().5, addedShipsCount)

    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
