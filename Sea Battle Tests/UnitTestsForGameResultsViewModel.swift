//
//  UnitTestsForGameResultsViewModel.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 19.10.23.
//

import XCTest
import SimpleKeychain
@testable import Sea_Battle

final class UnitTestsForGameResultsViewModel: XCTestCase {

    var gameResultsViewModel: GameResultsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameResultsViewModel = GameResultsViewModel()
        DataSavingManager.savingGameResult(with: .init(playerName: "A", playerIconDescription: Data.init(), opponentName: "B", opponentIconDescription: Data.init(), playerScores: 10, opponentScores: 20, isWinner: false))
        DataSavingManager.savingGameResult(with: .init(playerName: "C", playerIconDescription: Data.init(), opponentName: "D", opponentIconDescription: Data.init(), playerScores: 30, opponentScores: 20, isWinner: true))
        DataSavingManager.savingGameResult(with: .init(playerName: "E", playerIconDescription: Data.init(), opponentName: "F", opponentIconDescription: Data.init(), playerScores: 35, opponentScores: 20, isWinner: true))
        DataSavingManager.savingGameResult(with: .init(playerName: "G", playerIconDescription: Data.init(), opponentName: "H", opponentIconDescription: Data.init(), playerScores: 40, opponentScores: 20, isWinner: true))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameResultsViewModel = nil
        try? SimpleKeychain().deleteItem(forKey: "gameResult")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        let promise = expectation(description: "gettingData")
        //When
        gameResultsViewModel.getDataFromDataSource()
        getEndedCase(with: promise)
        //Then
        wait(for: [promise],timeout: 5)
        XCTAssertEqual(gameResultsViewModel.providedData[0].isWinner, true)
        XCTAssertEqual(gameResultsViewModel.providedData[0].opponentIconDescription, Data.init())
        XCTAssertEqual(gameResultsViewModel.providedData[0].opponentName, "H")
        XCTAssertEqual(gameResultsViewModel.providedData[0].opponentScore, 20)
        XCTAssertEqual(gameResultsViewModel.providedData[0].playerIconDescription, Data.init())
        XCTAssertEqual(gameResultsViewModel.providedData[0].playerName, "G")
        XCTAssertEqual(gameResultsViewModel.providedData[0].playerScores, 40)

    }
    
    func getEndedCase(with promise: XCTestExpectation) {
        if gameResultsViewModel.providedData.isEmpty {
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
