//
//  SnapshotSupport.swift
//  SwiftRadio
//
//  Created by Joe McMahon on 7/16/18.
//  Copyright © 2018 matthewfecher.com. All rights reserved.
//

import Foundation
func isRunningTests() -> Bool {
    return UserDefaults.standard.bool(forKey: "isRunningTests")
}

func isNotRunningTests() -> Bool {
    return !isRunningTests()
}
