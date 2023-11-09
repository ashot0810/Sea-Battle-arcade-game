//
//  UnitTestsForViewModelForBattleViewController.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 19.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForViewModelForBattleViewController: XCTestCase {

    var viewModelforBattle: ViewModelForBattleViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelforBattle = ViewModelForBattleViewController(dataModel: .init(dataForSelfMapSection: ["A"]), opponentPlayer: .init(playerName: "B", playerIconDescription: Data.init(), playergender: "boy", mapData: ["C"]), connectorStatus: .joiner)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelforBattle = nil
    }

    func testExampleOfMethods() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        
        //When
        viewModelforBattle.getDataForSelfMap()
        viewModelforBattle.getDataForOpponentMap()
        viewModelforBattle.setPlayingStatus(with: .canPlay)
        viewModelforBattle.setGameResultMin()
        //Then
        XCTAssertTrue(viewModelforBattle.providedDataForOpponentMapSection.count > 5)
        XCTAssertEqual(viewModelforBattle.provideOpponentName(), "B")
        XCTAssertEqual(viewModelforBattle.provideOpponentIcon(), Data.init())
        XCTAssertTrue(viewModelforBattle.canHit(to: IndexPath(item: 50, section: 0)))
        XCTAssertFalse(viewModelforBattle.canHit(to: IndexPath(item: 0, section: 0)))
        XCTAssertEqual(viewModelforBattle.providedDataForSelfMapSection, ["A"])
        XCTAssertEqual(viewModelforBattle.providePlayingStatus(), .canPlay)
        XCTAssertEqual(viewModelforBattle.gameResult.isWinner, false)
        XCTAssertEqual(viewModelforBattle.gameResult.opponentIconDescription, .init())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentName, viewModelforBattle.provideOpponentName())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentScore, 500)
        XCTAssertFalse(viewModelforBattle.gameResult.playerIconDescription.isEmpty)
        XCTAssertEqual(viewModelforBattle.gameResult.playerName, DataAboutPlayerSingleton.shared.providePlayerName())
        XCTAssertEqual(viewModelforBattle.gameResult.playerScores, 0)
        
        //Given
        
        //When
        viewModelforBattle.setGameResultMax()
        //Then
        XCTAssertEqual(viewModelforBattle.gameResult.isWinner, true)
        XCTAssertEqual(viewModelforBattle.gameResult.opponentIconDescription, .init())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentName, viewModelforBattle.provideOpponentName())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentScore, 0)
        XCTAssertFalse(viewModelforBattle.gameResult.playerIconDescription.isEmpty)
        XCTAssertEqual(viewModelforBattle.gameResult.playerName, DataAboutPlayerSingleton.shared.providePlayerName())
        XCTAssertEqual(viewModelforBattle.gameResult.playerScores, 500)
        
        //Given
        
        //When

        //Then
        XCTAssertEqual(viewModelforBattle.gameResult.isWinner, true)
        XCTAssertEqual(viewModelforBattle.gameResult.opponentIconDescription, .init())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentName, viewModelforBattle.provideOpponentName())
        XCTAssertEqual(viewModelforBattle.gameResult.opponentScore, 0)
        XCTAssertFalse(viewModelforBattle.gameResult.playerIconDescription.isEmpty)
        XCTAssertEqual(viewModelforBattle.gameResult.playerName, DataAboutPlayerSingleton.shared.providePlayerName())
        XCTAssertEqual(viewModelforBattle.gameResult.playerScores, 500)
        
        //MARK: To test make accessibility to private(set)
        //Given
        
        //When
//        viewModelforBattle.setMultipeerConnectivityHandler(with: .init(displayName: "A"))
        //Then
//        XCTAssertNotNil(viewModelforBattle.multipeerConectivityHandler)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
