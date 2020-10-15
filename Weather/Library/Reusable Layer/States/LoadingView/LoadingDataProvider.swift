protocol LoadingDataProvider {
    var config: LoadingViewConfig { get }

    func getBlocks() -> [LoadingViewBlockAbstract]
}

extension LoadingDataProvider {

    var config: LoadingViewConfig {
        return .init()
    }

}
