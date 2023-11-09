//
//  UnitTestsForSavedItemsViewModel.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 19.10.23.
//

import XCTest
import SimpleKeychain
@testable import Sea_Battle

final class UnitTestsForSavedItemsViewModel: XCTestCase {

    var viewModelForSavedItems: SavedItemsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelForSavedItems = SavedItemsViewModel()
        DataSavingManager.saveMapsImage(with: Data.init())
        DataSavingManager.saveMap(with: ["A"])
        DataSavingManager.saveShipsCount(with: 5)
        DataSavingManager.saveShipsLeftRotated(with: ["B"])
        DataSavingManager.saveShipsRightRotated(with: ["C"])
        DataSavingManager.saveWaterMarksData(with: [0:0])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelForSavedItems = nil
        try? SimpleKeychain().deleteItem(forKey: "savedMaps")
        UserDefaults.standard.removeObject(forKey: "savedShipsLeft")
        UserDefaults.standard.removeObject(forKey: "savedShipsRight")
        UserDefaults.standard.removeObject(forKey: "waterMarksData")
        UserDefaults.standard.removeObject(forKey: "savedMaps")
        UserDefaults.standard.removeObject(forKey: "shipsCount")

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        let promise = expectation(description: "gettingData")
        //When
        viewModelForSavedItems.getData()
        getEndedCase(with: promise)
        //Then
        wait(for: [promise],timeout: 5)
        XCTAssertFalse(viewModelForSavedItems.providedDataForMaps.isEmpty)
        XCTAssertFalse(viewModelForSavedItems.providedMapImageData.isEmpty)
        XCTAssertFalse(viewModelForSavedItems.providedShipsCountData.isEmpty)
        XCTAssertFalse(viewModelForSavedItems.providedDataAboutWaterMarks.isEmpty)
        XCTAssertFalse(viewModelForSavedItems.providedDataForShipsRotatedLeft.isEmpty)
        XCTAssertFalse(viewModelForSavedItems.providedDataForShipsRotatedRight.isEmpty)
        
        //Given
        
        //When
        
        //Then
        XCTAssertEqual(viewModelForSavedItems.providedDataForMaps[0], ["A"])
        XCTAssertEqual(viewModelForSavedItems.providedMapImageData[0], Data.init())
        XCTAssertEqual(viewModelForSavedItems.providedShipsCountData[0], 5)
        XCTAssertEqual(viewModelForSavedItems.providedDataAboutWaterMarks[0], [0:0])
        XCTAssertEqual(viewModelForSavedItems.providedDataForShipsRotatedLeft[0], ["B"])
        XCTAssertEqual(viewModelForSavedItems.providedDataForShipsRotatedRight[0], ["C"])
    }
    
    func getEndedCase(with promise: XCTestExpectation) {
        if viewModelForSavedItems.providedDataForMaps.isEmpty {
            getEndedCase(with: promise)
        } else {
            promise.fulfill()
            return
        }
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
