//
//  Functions.swift
//  CircleAnimation
//
//  Created by Hsiao, Wayne on 7/1/18.
//  Copyright © 2018 Hsiao, Wayne. All rights reserved.
//

import Foundation

func randomDurantionFrom(_ low: UInt32, to high: UInt32) -> Double {
    let randomDuration = Double((arc4random_uniform(high-low) + low))
    return randomDuration
}
