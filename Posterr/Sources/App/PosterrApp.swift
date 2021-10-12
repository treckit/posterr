//
// Created by Dmytro Seredinov
//

import SwiftUI

@main
struct PosterrApp: App {
    @StateObject var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            PostCollectionView(coordinator.postCollectionCoordinator.viewModel)
        }
    }
}
