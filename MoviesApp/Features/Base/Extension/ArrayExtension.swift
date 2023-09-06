//
//  ArrayExtension.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 05/09/23.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
