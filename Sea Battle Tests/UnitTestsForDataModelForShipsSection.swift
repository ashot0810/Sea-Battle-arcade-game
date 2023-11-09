//
//  UnitTestsForDataModelForShipsSection.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
@testable import Sea_Battle

final class UnitTestsForDataModelForShipsSection: XCTestCase {

    var dataModelForShipsSection: DataModelForShipsSection!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataModelForShipsSection = DataModelForShipsSection()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataModelForShipsSection = nil
    }

    func testExampleForProvidingMethods() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        
        //When
        
        //Then
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","TwoCellsShips","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
    }
    
    func testExampleForResetingMethod() {
        // Given
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","TwoCellsShips","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
        //When
        let providedData = dataModelForShipsSection.resetShipsDataModel()
        //Then
        
        XCTAssertEqual(providedData, [String].init(repeating: "", count: 10))
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), [String].init(repeating: "", count: 10))
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), [String].init(repeating: "", count: 10))
    }

    func testExampleForChangingMethod() {
        // Given
        dataModelForShipsSection = DataModelForShipsSection()
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","TwoCellsShips","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
        //When
        dataModelForShipsSection.changeData(on:5)
        //Then
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
    }
    
    func testExampleForInvalidChangingMethod() {
        // Given
        dataModelForShipsSection = DataModelForShipsSection()
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","TwoCellsShips","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
        //When
        dataModelForShipsSection.changeData(on:-1)
        dataModelForShipsSection.changeData(on: 100)
        //Then
        XCTAssertEqual(dataModelForShipsSection.provideDataForShipsSectionRotatedLeft(), ["OneCellShips","OneCellShips","OneCellShips","OneCellShips","TwoCellsShips","TwoCellsShips","TwoCellsShips","ThreeCellsShips","ThreeCellsShips","FourCellShips"])
        
        XCTAssertEqual(dataModelForShipsSection.provideDataForForShipSectionRotatedRight(), ["OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","OneCellShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","TwoCellsShipsRotated","ThreeCellsShipsRotated","ThreeCellsShipsRotated","FourCellShipsRotated"])
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
