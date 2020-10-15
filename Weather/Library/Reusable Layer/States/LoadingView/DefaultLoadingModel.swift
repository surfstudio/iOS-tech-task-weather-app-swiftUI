import UIKit

/// Дефолтная модель для конфигурации отступов
struct DefaultLoadingModel {
    let topOffset: CGFloat
    let bottomOffset: CGFloat

    init(topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
    }
}
