//
//  Error.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 04/09/23.
//

import Foundation
import SwiftUI

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error?
}


class AppState {
    var errorWrapper: ErrorWrapper?
}

struct ErrorWrapperKey:EnvironmentKey {
    static var defaultValue: AppState = AppState()
    
}

