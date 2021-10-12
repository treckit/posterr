//
// Created by Dmytro Seredinov
//


import Foundation

public enum ExecutionState
{
    case idle
    case loading
    case failed(_ error: Posterr.Error? = nil)
}
