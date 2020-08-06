//
//  NetworkStatusManager.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 06/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

enum NotificationsMessage: String {
    case networkStatusChanged
    
    var name: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}

class NetworkStatusManager {
    static let shared: NetworkStatusManager = NetworkStatusManager()
    var currentNetworkStatus: Reachability.Connection = Reachability.Connection.unavailable {
        didSet {
            statusChanged()
        }
    }
    private var reachability: Reachability?

    init() {
        setup()
    }
    func isInternetConnected() -> Bool {
        if currentNetworkStatus == .unavailable {
            return false
        } else {
            return true
        }
    }
    private func setup() {
        reachability = try? Reachability()

        reachability?.whenReachable = { [weak self] reachability in
            self?.currentNetworkStatus = reachability.connection
        }
        reachability?.whenUnreachable = { [weak self] reachability in
            self?.currentNetworkStatus = reachability.connection
        }

        do {
            try reachability?.startNotifier()
            guard let connection = reachability?.connection else { return }
            currentNetworkStatus = connection
        } catch {
            print("Unable to start notifier")
        }
    }
    private func statusChanged() {
        //TODO: - add observers to notify network status changed
        NotificationCenter.default.post(Notification(name: NotificationsMessage.networkStatusChanged.name))
    }
}
