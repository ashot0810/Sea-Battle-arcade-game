//
//  UnitTestsForDataSourceForGameResultsForViewModelAndDecodeManager.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
import SimpleKeychain
@testable import Sea_Battle

final class UnitTestsForDataSourceForGameResultsForViewModelAndDecodeManager: XCTestCase {
    
    var dataSourceForGameResults: DataSourceForGameResultsForViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSourceForGameResults = DataSourceForGameResultsForViewModel()
        let savingData = [GameWinnerLoserResult(playerName: "A", playerIconDescription: Data.init(), opponentName: "B", opponentIconDescription: Data.init(), playerScores: 1, opponentScores: 1, isWinner: false)]
        guard let encodedData = try? JSONEncoder().encode(savingData) else {return}
        try? SimpleKeychain().set(encodedData, forKey: "gameResult")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSourceForGameResults = nil
        try? SimpleKeychain().deleteItem(forKey: "gameResult")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        //Given
        dataSourceForGameResults = DataSourceForGameResultsForViewModel()
        //When
        
        //Then
        XCTAssertTrue(!dataSourceForGameResults.provideData().isEmpty)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
