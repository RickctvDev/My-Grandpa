//
//  Extensions.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//
//
//
// This class is used to make it work with update to move nodes on the screen via update on viewcontroller // You can check in CLOUD CLASS to see how we used it and on mainMenu view controller

import Foundation
import SpriteKit

protocol Updatable: class {
    func update(currentTime: TimeInterval)
}
