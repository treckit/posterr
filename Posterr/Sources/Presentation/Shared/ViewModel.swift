//
// Created by Dmytro Seredinov
//


import Foundation
import Combine
import SwiftUI

public class ViewModel: ObservableObject, Identifiable
{
    @Published var error: Error?
    @Published var loading: Bool = false
    
    internal var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
}

