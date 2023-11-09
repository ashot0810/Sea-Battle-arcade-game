//
//  UnitTestsForViewModelForPlayersTableView.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 19.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForViewModelForPlayersTableView: XCTestCase {
    
    var viewModelForPlayersTableView: ViewModelForPlayersTableView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelForPlayersTableView = ViewModelForPlayersTableView()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        
        //When
        viewModelForPlayersTableView.setConnectivityHandler(with: .init(displayName: "Test"))
        //Then
        XCTAssertNotNil(viewModelForPlayersTableView.multipeerConnectivityForPlayers)
        
        //Given
        
        //When
        viewModelForPlayersTableView.getPeerId(.init(displayName: "Test"), peerId: .init(displayName: "Test"), discoveryInfo: nil, with: .get)
        viewModelForPlayersTableView.setConnectionState(.init(displayName: "Test"), for: IndexPath(item: 0, section: 0), with: .connected)
        
        //Then
        XCTAssertTrue(viewModelForPlayersTableView.isConnected())
        XCTAssertTrue(viewModelForPlayersTableView.providePeerId(at: IndexPath(item: 0, section: 0)).displayName == "Test") 
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
