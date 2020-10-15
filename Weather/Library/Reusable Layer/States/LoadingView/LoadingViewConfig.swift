import UIKit

public struct LoadingViewConfig {

    // MARK: - Properties

    /// отсуп от верха для первого блока
    let topOffset: CGFloat
    /// Цвет каким для плейсхолдеров
    let placeholderColor: UIColor
    /// Нужен ли градиент (красиво будет уменьшать альфу к низу)
    let needGradient: Bool
    /// Будет повторять последний блок до конца экрана
    let needRepeatLast: Bool

    // MARK: - Initialization

    public init(topOffset: CGFloat = 0,
                placeholderColor: UIColor = Asset.Color.black.color,
                needGradient: Bool = false,
                needRepeatLast: Bool = true) {
        self.topOffset = topOffset
        self.placeholderColor = placeholderColor
        self.needGradient = needGradient
        self.needRepeatLast = needRepeatLast
    }

}
