//
//  FileManager-DocumentDirectory.swift
//  HighRollers
//
//  Created by CEVAT UYGUR on 20.04.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
