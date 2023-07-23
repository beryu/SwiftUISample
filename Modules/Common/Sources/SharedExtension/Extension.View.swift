import SwiftUI

extension View {
  public func cellTitleText() -> some View {
    font(.system(size: 20, weight: .semibold))
      .foregroundColor(Color.black)
  }

  public func bodyText() -> some View {
    font(.system(size: 14, weight: .regular))
      .foregroundColor(Color.black)
  }
}
