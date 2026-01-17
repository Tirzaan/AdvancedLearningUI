//
//  CloudKitUser.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/13/26.
//

import SwiftUI
import Combine
import CloudKit

// NEEDS Paid Apple Developer Account

//@MainActor
final class CloudKitUserViewModel: ObservableObject {
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""

    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnederror in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                    self?.error = ""
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountTemporarilyUnavailable
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self.userName = name
                }
            }
        }
    }
}

struct CloudKitUser: View {
    @StateObject private var viewModel = CloudKitUserViewModel()
    
    var body: some View {
        VStack {
            Text("Is Signed In \(viewModel.isSignedInToiCloud.description)")
            Text(viewModel.error)
            Text("Permission: \(viewModel.permissionStatus.description)")
            Text("Name: \(viewModel.userName)")
        }
    }
}

#Preview {
    CloudKitUser()
}
