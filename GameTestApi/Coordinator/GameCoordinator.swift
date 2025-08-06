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
  func push(_ route: Route) { path.append(route) }
  func popToRoot() { path.removeLast(path.count) }
}
