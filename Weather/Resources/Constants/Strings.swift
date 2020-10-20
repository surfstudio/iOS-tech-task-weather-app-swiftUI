// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L10n {

  public enum Common {
    public enum Button {
      /// Добавить город
      public static let addCity = L10n.tr("Localizable", "Common.Button.addCity")
      /// Отмена
      public static let cancel = L10n.tr("Localizable", "Common.Button.cancel")
      /// Готово
      public static let done = L10n.tr("Localizable", "Common.Button.done")
      /// Изменить
      public static let edit = L10n.tr("Localizable", "Common.Button.edit")
      /// Повторить
      public static let `repeat` = L10n.tr("Localizable", "Common.Button.repeat")
    }
    public enum TextField {
      /// Город или индекс
      public static let search = L10n.tr("Localizable", "Common.TextField.search")
    }
  }

  public enum Detail {
    /// Облачность
    public static let clouds = L10n.tr("Localizable", "Detail.clouds")
    /// Влажность
    public static let humidity = L10n.tr("Localizable", "Detail.humidity")
    /// Макс. %.0f°, мин.  %.0f°
    public static func maxmin(_ p1: Float, _ p2: Float) -> String {
      return L10n.tr("Localizable", "Detail.maxmin", p1, p2)
    }
    /// Осадки, мм
    public static let precipitation = L10n.tr("Localizable", "Detail.precipitation")
    /// Давление, мм
    public static let pressure = L10n.tr("Localizable", "Detail.pressure")
    /// Сегодня
    public static let today = L10n.tr("Localizable", "Detail.today")
    /// Ветер, мс
    public static let windSpeed = L10n.tr("Localizable", "Detail.windSpeed")
  }

  public enum Empty {
    /// Не выбран ни один город для просмотра прогноза
    public static let cities = L10n.tr("Localizable", "Empty.cities")
    /// Ничего не удалось найти. Попробуйте изменить запрос
    public static let request = L10n.tr("Localizable", "Empty.request")
  }

  public enum Error {
    /// Данные не актуальны. Обновляем
    public static let dataIsExpired = L10n.tr("Localizable", "Error.dataIsExpired")
    /// Отсутствует соединение с интернетом. Попробуйте позже
    public static let noInternetConnection = L10n.tr("Localizable", "Error.noInternetConnection")
    /// Что-то пошло не так. Не удалось загрузить данные
    public static let notDefined = L10n.tr("Localizable", "Error.notDefined")
    /// Ничего не нашлось по этому запросу ):
    public static let notFound = L10n.tr("Localizable", "Error.notFound")
  }

  public enum List {
    /// Города
    public static let title = L10n.tr("Localizable", "List.title")
    public enum Cells {
      public enum AddCity {
        /// Добавить город
        public static let title = L10n.tr("Localizable", "List.Cells.AddCity.title")
      }
      public enum City {
        /// %.0f°
        public static func temperature(_ p1: Float) -> String {
          return L10n.tr("Localizable", "List.Cells.City.temperature", p1)
        }
      }
    }
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
