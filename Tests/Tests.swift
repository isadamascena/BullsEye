//
//  Tests.swift
//  Tests
//
//  Created by lalonso on 09/04/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import XCTest

@testable import BullsEye

class Tests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        viewController.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStartNewGame() {
        viewController.startNewGame()

        XCTAssertEqual(viewController.score, 0)
    }
    
    func testScoreAfterAPerfectScuccess() {
        viewController.targetValue = 70
        viewController.currentValue = 70

        viewController.showAlert()

        XCTAssertEqual(viewController.score, 200)
    }
    
}
