import SwiftUI

extension View {
  public func pageTitleText() -> some View {
    font(.system(size: 25, weight: .semibold))
      .foregroundColor(Color.black)
  }

  public func pageSubtitleText() -> some View {
    font(.system(size: 19, weight: .regular))
      .foregroundColor(Color.black)
  }

  public func cellTitleText() -> some View {
    font(.system(size: 19, weight: .semibold))
      .foregroundColor(Color.black)
  }

  public func bodyText() -> some View {
    font(.system(size: 14, weight: .regular))
      .foregroundColor(Color.black)
  }

  public func bodyBoldText() -> some View {
    font(.system(size: 14, weight: .semibold))
      .foregroundColor(Color.black)
  }
}
