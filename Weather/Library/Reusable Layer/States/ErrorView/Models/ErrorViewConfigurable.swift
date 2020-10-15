import SurfUtils

protocol ErrorViewConfigurable {
    var actionStyle: UIStyle<UIButton> { get }
    var messageStyle: UIStyle<UILabel> { get }
    var iconWidth: CGFloat { get }
    var messageTopOffset: CGFloat { get }
    var icon: UIImage { get }
}
