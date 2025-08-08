//
//  GameCoordinator.swift
//  GameTestApi
//
//  Created by Juan Aguilar on 05/08/25.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ route: Route)
    func popToRoot()
}

final class GamesCoordinator: Coordinator {
    @Published var path = NavigationPath()
    @Published var sheetToShow: SheetRoute? = nil
    
    func push(_ route: Route) { path.append(route) }
    func popToRoot() { path.removeLast(path.count) }
    
    // MARK: - Routes direction
    func goToDashboard() { push(.dashboard) }
    func goToError(with errorMessage: String) { push(.error(error: errorMessage)) }
    
    // Soporte para modales
    enum SheetRoute: Identifiable {
        case detail(GameModel)
        var id: String {
            switch self {
            case .detail(let game): return "favorite_\(game.id)"
            }
        }
    }
    
    func presentDetail(for game: GameModel) {
        sheetToShow = .detail(game)
    }
    
    func dismissSheet() {
        sheetToShow = nil
    }
}

enum Route: Hashable {
    case dashboard
    case error(error: String)
    case detail
}
