//
//  OnboardingModel.swift
//  NewsToDayApp
//
//  Created by Churkin Vitaly on 25.10.2024.
//

struct OnboardingModel {
    let title: String
    let description: String
    let image: String
}

extension OnboardingModel {
    static let models: [OnboardingModel] = [
        .init(
            title: "First to know".localized(),
            description: "All news in one place, be the first to know last news".localized(),
            image: "OnboardingTimesSquare"
        ),
        .init(
            title: "",
            description: "All news in one place, be the first to know last news".localized(),
            image: "OnboardingCityView"
        ),
    ]
}
