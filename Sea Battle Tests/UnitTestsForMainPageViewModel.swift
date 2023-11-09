//
//  UnitTestsForMainPageViewModel.swift
//  Sea Battle Tests
//
//  Created by Ashot Hovhannisyan on 18.10.23.
//

import XCTest
import SimpleKeychain
import UIKit.UIImage
@testable import Sea_Battle

final class UnitTestsForMainPageViewModel: XCTestCase {

    var mainPageViewModel: MainPageViewModel!
    
    override func setUpWithError() throws {
        mainPageViewModel = MainPageViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mainPageViewModel = nil
        try? SimpleKeychain().deleteItem(forKey: "playerImage")
    }

    func testExamples() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        //Given
        
        //When
        mainPageViewModel.configuirePlayersVolume(with: 0.5)
        //Then
        XCTAssertEqual(AudioEffectsManager.volume, 0.5)
        
        //Given
        mainPageViewModel = MainPageViewModel()
        //When
        mainPageViewModel.configuireHaptick(with: false)
        //Then
        XCTAssertEqual(AudioEffectsManager.isHaptickEnable, false)
        
        //Given
        mainPageViewModel = MainPageViewModel()
        //When
        mainPageViewModel.setVolumeSliderValue(with: 0.5)
        //Then
        XCTAssertEqual(mainPageViewModel.volumeSliderValue, 0.5)
        
        //Given
        let image = UIImage(named: "ShipsMapsBackground")
        let promise = expectation(description: "imageSaving")
        //When
        if let image {
            mainPageViewModel.askToSetPlayerImage(with: image)
        }
        let gettedImage = DataSavingManager.provideImage()
        promise.fulfill()
        //Then
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(gettedImage)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
