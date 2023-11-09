//
//  UnitTestsForDataSourceForPlayersTableView.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
import MultipeerConnectivity
@testable import Sea_Battle

final class UnitTestsForDataSourceForPlayersTableView: XCTestCase {

    var dataSourceForPlayerTableView:DataSourceForPlayersTableView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSourceForPlayerTableView = DataSourceForPlayersTableView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSourceForPlayerTableView = nil
    }

    func testExampleOfMutatingAndProvidingMethods() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        
        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .get)
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "B"), discoveryInfo: ["gender":"girl"], with: .get)
        //Then
        XCTAssertTrue(dataSourceForPlayerTableView.provideDataForIcons().count == 2)
        
        //Given
        dataSourceForPlayerTableView = DataSourceForPlayersTableView()
        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .lost)
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "B"), discoveryInfo: ["gender":"girl"], with: .lost)
        //Then
        XCTAssertTrue(dataSourceForPlayerTableView.provideDataForNames().isEmpty)
        
        //Given

        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .get)
        //Then
        XCTAssertTrue(dataSourceForPlayerTableView.setUpWithConnectionStates() == [.notNonnected])
        
        //Given
        dataSourceForPlayerTableView = DataSourceForPlayersTableView()
        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .get)
        //Then
        XCTAssertTrue(dataSourceForPlayerTableView.providePeerId(at: IndexPath(item: 0, section: 0)).displayName == "A" )
        
        //Given
        dataSourceForPlayerTableView = DataSourceForPlayersTableView()
        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .get)
        //Then
        XCTAssertTrue(dataSourceForPlayerTableView.provideDataForNames() == ["A"] )
        XCTAssertTrue(dataSourceForPlayerTableView.provideDataForIcons()[0] != nil)
            
        //Given
        dataSourceForPlayerTableView = DataSourceForPlayersTableView()
        //When
        dataSourceForPlayerTableView.handleIncomingData(data: MCPeerID(displayName: "A"), discoveryInfo: ["gender":"boy"], with: .get)
        _ = dataSourceForPlayerTableView.setUpWithConnectionStates()
        dataSourceForPlayerTableView.setConnectionState(for: IndexPath(item: 0, section: 0), with: .connected)
        //Then
       // XCTAssertTrue(dataSourceForPlayerTableView.connectingState == [.connected]) //To test go and make property with private(set) accessibility
        
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
