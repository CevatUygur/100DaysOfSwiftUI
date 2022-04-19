//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by CEVAT UYGUR on 19.04.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
