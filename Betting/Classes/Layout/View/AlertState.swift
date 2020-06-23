//
//  AlertState.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

final class AlertState {
    enum AlertType {
        case confirmBeforeSignIn
        case developerError
        case maintenance
        case requiredRetry
        case networkError
        case signInFailed
        case canNotAddFavorite
        case ownedPhoto
        case alreadyAddFavorite
        case successFavorite
        case none
    }

    internal var state: Bool
    private var type: AlertType
    private var action: () -> Void

    init(state: Bool = false, type: AlertType = .none, action: @escaping () -> Void = {}) {
        self.state = state
        self.type = type
        self.action = action
    }

    internal var alert: Alert {
        var title = ""
        var message = ""
        var primaryButton = ""
        var secondaryButton = ""

        switch type {
        case .confirmBeforeSignIn:
            title = L10n.Alert.SignIn.title
            message = L10n.Alert.SignIn.message
            primaryButton = L10n.Common.signIn
            secondaryButton = L10n.Common.later
        case .developerError:
            title = L10n.Alert.Error.title
            message = L10n.Alert.DeveloperError.message
            primaryButton = L10n.Common.ok
        case .maintenance:
            title = L10n.Alert.Error.title
            message = L10n.Alert.Maintenance.message
            primaryButton = L10n.Common.ok
        case .requiredRetry:
            title = L10n.Alert.Error.title
            message = L10n.Alert.RequiredRetry.message
            primaryButton = L10n.Common.ok
        case .networkError:
            title = L10n.Alert.Error.title
            message = L10n.Alert.NetworkError.message
            primaryButton = L10n.Common.ok
        case .signInFailed:
            title = L10n.Alert.Error.title
            message = L10n.Alert.SignInError.message
            primaryButton = L10n.Common.ok
        case .canNotAddFavorite:
            title = L10n.Alert.Error.title
            message  = L10n.Alert.CanNotAddFavorite.message
            primaryButton = L10n.Common.ok
        case .ownedPhoto:
            title = L10n.Alert.Error.title
            message = L10n.Alert.OwnedPhoto.message
            primaryButton = L10n.Common.ok
        case .alreadyAddFavorite:
            title = L10n.Alert.Error.title
            message = L10n.Alert.AlreadyAddFavorite.message
            primaryButton = L10n.Common.ok
        case .successFavorite:
            title = L10n.Alert.SuccessFavorite.title
            message = L10n.Alert.SuccessFavorite.message
            primaryButton = L10n.Common.ok
        case .none:
            break
        }

        switch type {
        case .confirmBeforeSignIn:
            return Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(Text(primaryButton),
                    action: {
                        self.action()
                    }
                ),
                secondaryButton: .default(Text(secondaryButton))
            )
        case .developerError,
             .maintenance,
             .networkError,
             .requiredRetry,
             .signInFailed,
             .canNotAddFavorite,
             .ownedPhoto,
             .alreadyAddFavorite,
             .successFavorite,
             .none:
            return Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(primaryButton))
            )
        }
    }
}
