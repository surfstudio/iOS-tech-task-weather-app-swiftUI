//
//  AddCityViewInput.swift
//  Weather
//

protocol AddCityViewInput: class, LoaderDisplayable, StateConfigurable, SnackDisplayable {
    func update(citites: [PlacesSuggestionEntity])
}
