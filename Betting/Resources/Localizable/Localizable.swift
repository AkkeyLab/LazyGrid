// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Alert {
    internal enum AlreadyAddFavorite {
      /// It is a photo already registered as a favorite.
      internal static let message = L10n.tr("Localizable", "alert.already_add_favorite.message")
    }
    internal enum CanNotAddFavorite {
      /// This photo cannot be registered as a favorite.
      internal static let message = L10n.tr("Localizable", "alert.can_not_add_favorite.message")
    }
    internal enum DeveloperError {
      /// We apologize, but please contact the management.
      internal static let message = L10n.tr("Localizable", "alert.developer_error.message")
    }
    internal enum Error {
      /// Sorry
      internal static let title = L10n.tr("Localizable", "alert.error.title")
    }
    internal enum Maintenance {
      /// currently undergoing maintenance. Please wait for a while before using.
      internal static let message = L10n.tr("Localizable", "alert.maintenance.message")
    }
    internal enum NetworkError {
      /// Communication failed. Please check the communication environment.
      internal static let message = L10n.tr("Localizable", "alert.network_error.message")
    }
    internal enum OwnedPhoto {
      /// Photos posted by yourself cannot be registered as favorites.
      internal static let message = L10n.tr("Localizable", "alert.owned_photo.message")
    }
    internal enum RequiredRetry {
      /// Communication failed. Please try restarting the app.
      internal static let message = L10n.tr("Localizable", "alert.required_retry.message")
    }
    internal enum SignIn {
      /// You can manage your only photos!
      internal static let message = L10n.tr("Localizable", "alert.sign_in.message")
      /// Sign in with Flickr
      internal static let title = L10n.tr("Localizable", "alert.sign_in.title")
    }
    internal enum SignInError {
      /// Sign in failed. Please try again.
      internal static let message = L10n.tr("Localizable", "alert.sign_in_error.message")
    }
    internal enum SuccessFavorite {
      /// Congratulations! You can always check from My Page.
      internal static let message = L10n.tr("Localizable", "alert.success_favorite.message")
      /// Completion of registration
      internal static let title = L10n.tr("Localizable", "alert.success_favorite.title")
    }
  }

  internal enum Button {
    internal enum Favorite {
      /// Sign in to add your favorite photos!
      internal static let `subscript` = L10n.tr("Localizable", "button.favorite.subscript")
      /// Add Photos to Favorites
      internal static let title = L10n.tr("Localizable", "button.favorite.title")
    }
    internal enum ShowFavoritePhotos {
      /// My Favorite Photos
      internal static let title = L10n.tr("Localizable", "button.show_favorite_photos.title")
    }
    internal enum SignIn {
      /// Sign in with Flickr
      internal static let title = L10n.tr("Localizable", "button.sign_in.title")
    }
  }

  internal enum Common {
    /// Later
    internal static let later = L10n.tr("Localizable", "common.later")
    /// OK
    internal static let ok = L10n.tr("Localizable", "common.ok")
    /// Sign in
    internal static let signIn = L10n.tr("Localizable", "common.sign_in")
  }

  internal enum Unit {
    /// JPY
    internal static let price = L10n.tr("Localizable", "unit.price")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
