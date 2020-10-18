import SurfUtils

class SearchBarStyle: UIStyle<UISearchBar> {

    // MARK: - Private Properties

    // MARK: - Lifecycle

    // MARK: - UIStyle

    override func apply(for view: UISearchBar) {
        view.backgroundColor = Asset.Color.lightGrey.color
        view.tintColor = Asset.Color.darkGrey.color
        view.setImage(Asset.Image.Search.iconSearch.image, for: .search, state: .normal)
        view.returnKeyType = .done

        let field = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])

        field.backgroundColor = Asset.Color.lightPurple.color

        let fieldTextAttrs: [StringAttribute] = [
            .font(FontFamily.SFProText.medium.font(size: 14.0)),
            .foregroundColor(Asset.Color.black.color),
            .aligment(.left)
        ]

        let fieldPlaceholderAttrs: [StringAttribute] = [
            .font(FontFamily.SFProText.medium.font(size: 14.0)),
            .foregroundColor(Asset.Color.grey.color),
            .aligment(.left)
        ]

        field.defaultTextAttributes = fieldTextAttrs.toDictionary()
        field.attributedPlaceholder = view.placeholder?.with(attributes: fieldPlaceholderAttrs)

        let cancelAttrs: [StringAttribute] = [
            .font(FontFamily.SFProText.bold.font(size: 14.0)),
            .foregroundColor(Asset.Color.darkGrey.color),
            .aligment(.left)
        ]

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelAttrs.toDictionary(), for: .normal)
    }
}
