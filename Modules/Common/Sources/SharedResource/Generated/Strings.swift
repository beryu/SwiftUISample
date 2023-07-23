// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Common {
    public enum Loading {
      /// Loading...
      public static let text = L10n.tr("Localizable", "Common.loading.text", fallback: "Loading...")
    }
    public enum Title {
      /// # Naming rules
      /// 
      ///  `Feature.featureDetail.component.(sub-feature)`
      /// 
      ///  - Separate by period.
      ///  - Use Lower Camel Case
      ///  - In 1st layer, Use Upper Camel Case.
      ///  - 1st layer means the feature, like a category.
      ///  - 2nd layer means the feature in detail.
      ///  - 3rd layer means the component.
      ///  - (Optional) In 4th layer means the sub-feature.
      public static let text = L10n.tr("Localizable", "Common.title.text", fallback: "GitHub Viewer")
    }
  }
  public enum UserList {
    public enum LoadError {
      public enum Alert {
        /// Please scroll to top and pull to refresh
        public static let message = L10n.tr("Localizable", "UserList.loadError.alert.message", fallback: "Please scroll to top and pull to refresh")
        /// Error was occured when loading
        public static let title = L10n.tr("Localizable", "UserList.loadError.alert.title", fallback: "Error was occured when loading")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
