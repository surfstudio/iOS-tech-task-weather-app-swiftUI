// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  public typealias AssetColorTypeAlias = NSColor
  public typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  public typealias AssetColorTypeAlias = UIColor
  public typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Color {

    public static let black = ColorAsset(name: "Color/black")
    public static let black05 = ColorAsset(name: "Color/black05")
    public static let black40 = ColorAsset(name: "Color/black40")
    public static let black50 = ColorAsset(name: "Color/black50")
    public static let cyan = ColorAsset(name: "Color/cyan")
    public static let darkGrey = ColorAsset(name: "Color/darkGrey")
    public static let grey = ColorAsset(name: "Color/grey")
    public static let lightGrey = ColorAsset(name: "Color/lightGrey")
    public static let lightPurple = ColorAsset(name: "Color/lightPurple")
    public static let white = ColorAsset(name: "Color/white")
    public static let white40 = ColorAsset(name: "Color/white40")
  }
  public enum Image {

    public enum Background {
      public static let clear = ImageAsset(name: "Image/Background/clear")
      public static let clouds = ImageAsset(name: "Image/Background/clouds")
      public static let fog = ImageAsset(name: "Image/Background/fog")
      public static let rain = ImageAsset(name: "Image/Background/rain")
      public static let snow = ImageAsset(name: "Image/Background/snow")
      public static let sun = ImageAsset(name: "Image/Background/sun")
      public static let thunderstorm = ImageAsset(name: "Image/Background/thunderstorm")
    }
    public enum ErrorView {
      public static let emptyState = ImageAsset(name: "Image/ErrorView/empty_state")
      public static let errorState = ImageAsset(name: "Image/ErrorView/error_state")
      public static let noInternet = ImageAsset(name: "Image/ErrorView/no_internet")
      public static let noLocation = ImageAsset(name: "Image/ErrorView/no_location")
    }
    public enum NavigationItem {
      public static let back = ImageAsset(name: "Image/NavigationItem/back")
      public static let list = ImageAsset(name: "Image/NavigationItem/list")
    }
    public enum Search {
      public static let iconSearch = ImageAsset(name: "Image/Search/icon-search")
    }
    public enum Utils {
      public static let plus = ImageAsset(name: "Image/Utils/plus")
      public static let remove = ImageAsset(name: "Image/Utils/remove")
    }
    public enum Weather {
      public static let cloud = ImageAsset(name: "Image/Weather/cloud")
      public static let clouds = ImageAsset(name: "Image/Weather/clouds")
      public static let fog = ImageAsset(name: "Image/Weather/fog")
      public static let moon = ImageAsset(name: "Image/Weather/moon")
      public static let moonCloud = ImageAsset(name: "Image/Weather/moon_cloud")
      public static let rain = ImageAsset(name: "Image/Weather/rain")
      public static let snow = ImageAsset(name: "Image/Weather/snow")
      public static let sun = ImageAsset(name: "Image/Weather/sun")
      public static let sunCloud = ImageAsset(name: "Image/Weather/sun_cloud")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ColorAsset {
  public fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  public var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

public extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct DataAsset {
  public fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  public var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
public extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct ImageAsset {
  public fileprivate(set) var name: String

  public var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

public extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
