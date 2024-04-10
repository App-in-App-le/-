//
//  DispatchQueueType.swift
//  Or-rock-Nari-lock
//
//  Created by 황지웅 on 3/1/24.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}
