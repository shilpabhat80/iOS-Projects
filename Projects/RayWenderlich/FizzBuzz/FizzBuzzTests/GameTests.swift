//
//  GameTests.swift
//  FizzBuzz
//
//  Created by Shilpa Bhat on 16/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class GameTests: XCTestCase {
    
    let game = Game()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGameStartsAtZero() {
        XCTAssertTrue(game.score == 0)
    }

    func testOnPlayScoreIncremented() {
        game.play()
        XCTAssertTrue(game.score == 1)
    }

    func testOnPlayTwiceScoreIncremented() {
        game.play()
        game.play()
        XCTAssertTrue(game.score == 2)
    }
}

