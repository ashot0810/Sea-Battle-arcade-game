//
//  UnitTestsForViewModelForMapAndShips.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 19.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForViewModelForMapAndShips: XCTestCase {

    var viewModelForMapsAndShips: ViewModelForMapAndShips!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelForMapsAndShips = ViewModelForMapAndShips()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelForMapsAndShips = nil
    }

    func testExampleOfAppIdletimerDesabler() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given

        //When
        viewModelForMapsAndShips.turnOffAppsIdletimer()
        //Then
        XCTAssertTrue(UIApplication.shared.isIdleTimerDisabled)
    }
    
    func testExampleOfDataGetting() {
        //Given
        viewModelForMapsAndShips = ViewModelForMapAndShips(mapDataModel: .init(dataModelForMap: ["A"], waterMarksCounting: [0:0]), shipsDataMode: .init(dataForShipsLeft: ["B"], dataForShipsRight: ["C"]), shipsCount: 5)
        //When
        viewModelForMapsAndShips.getMapDataModel()
        viewModelForMapsAndShips.getShipsDataModel()
        //Then
        XCTAssertEqual(viewModelForMapsAndShips.givenDataForMap, ["A"])
        XCTAssertEqual(viewModelForMapsAndShips.givenDataOfShips, ["B"])
        
        //Given
        viewModelForMapsAndShips = ViewModelForMapAndShips(mapDataModel: .init(dataModelForMap: ["A"], waterMarksCounting: [0:0]), shipsDataMode: .init(dataForShipsLeft: ["B"], dataForShipsRight: ["C"]), shipsCount: 5)
        //When
        viewModelForMapsAndShips.getShipsDataModelRotated()
        viewModelForMapsAndShips.restoreData()
        //Then
        XCTAssertEqual(viewModelForMapsAndShips.givenDataOfShips, ["C"])
        XCTAssertTrue(viewModelForMapsAndShips.givenDataForMap.isEmpty)
        
    }
    
    func testExampleOfDataProviding() {
        //Given
        viewModelForMapsAndShips = ViewModelForMapAndShips(mapDataModel: .init(dataModelForMap: ["A"], waterMarksCounting: [0:0]), shipsDataMode: .init(dataForShipsLeft: ["B"], dataForShipsRight: ["C"]), shipsCount: 10)
        //When
        viewModelForMapsAndShips.getMapDataModel()
        viewModelForMapsAndShips.getShipsDataModel()
        //Then
        XCTAssertTrue(viewModelForMapsAndShips.isFullMapSetted())
        
        //Given
        viewModelForMapsAndShips = ViewModelForMapAndShips(mapDataModel: .init(dataModelForMap: ["A"], waterMarksCounting: [0:0]), shipsDataMode: .init(dataForShipsLeft: ["B"], dataForShipsRight: ["C"]), shipsCount: 5)
        //When
        viewModelForMapsAndShips.getMapDataModel()
        viewModelForMapsAndShips.getShipsDataModel()
        //Then
        XCTAssertFalse(viewModelForMapsAndShips.isFullMapSetted())
        XCTAssertEqual(viewModelForMapsAndShips.provide(), [0:0])
        
        //Given
        
        //When
        viewModelForMapsAndShips.setButtonType(with: .join)
        //Then
        XCTAssertEqual(viewModelForMapsAndShips.provideButtonType(), .join)
        
        //Given
        
        //When
        viewModelForMapsAndShips.setButtonType(with: .start)
        //Then
        XCTAssertEqual(viewModelForMapsAndShips.provideButtonType(), .start)
        
        //Given
        viewModelForMapsAndShips = ViewModelForMapAndShips(mapDataModel: .init(dataModelForMap: ["mapCellMarked"], waterMarksCounting: [0:0]), shipsDataMode: .init(dataForShipsLeft: ["B"], dataForShipsRight: ["C"]), shipsCount: 5)
        //When
        viewModelForMapsAndShips.getMapDataModel()
        viewModelForMapsAndShips.getShipsDataModel()
        //Then
        XCTAssertEqual(viewModelForMapsAndShips.provideDataForSelfMapOnBattle(), ["mappCelll"])
        XCTAssertEqual(viewModelForMapsAndShips.getData(on: 0), "mapCellMarked")
    }
    
    func testExampleOfSettingMethods() {
        //Given
        //When
//        viewModelForMapsAndShips.setMultipeerConectivityHandler(with: "A")
        //Then
        //MARK: To test go and make accessibilty private(set)
//        XCTAssertNotNil(viewModelForMapsAndShips.multipeerConectivityHandler)
//        XCTAssertNotNil(viewModelForMapsAndShips.provideConnectivityHandler())
        
        //Given
        
        //When
        viewModelForMapsAndShips.provideIndexPathsForHighlighting(indexPath: IndexPath(item: 50, section: 0), shipIndentificator: .twoCellShip)
        viewModelForMapsAndShips.prepareToRemoveShip(on: IndexPath(item: 45, section: 0))
        viewModelForMapsAndShips.getRandomAddedMap()
        //Then
        XCTAssertFalse(viewModelForMapsAndShips.setOfIndexPathsForHighlighting.isEmpty)
        //MARK: To test go and make accessibilty private(set)
//        XCTAssertNotNil(viewModelForMapsAndShips.shipIndexPath)
        XCTAssertTrue(!viewModelForMapsAndShips.givenDataForMap.isEmpty)
        XCTAssertTrue(viewModelForMapsAndShips.givenDataOfShips.allSatisfy({$0 == ""}))
        XCTAssertTrue(viewModelForMapsAndShips.isFullMapSetted())
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
