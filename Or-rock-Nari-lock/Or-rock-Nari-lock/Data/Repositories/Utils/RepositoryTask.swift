//
//  RepositoryTask.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 2/29/24.
//

import Foundation

final class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false

    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
