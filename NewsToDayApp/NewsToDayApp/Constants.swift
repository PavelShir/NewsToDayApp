import UIKit

struct K {
    static let appName = "NewsToDayApp"

    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height

    struct Categories {
        
        static let sports = "🏈 Sports"
        static let politics = "⚖️ Politics"
        static let life = "🌞 Life"
        static let gaming = "🎮 Gaming"
        static let animals = "🐻 Animals"
        static let nature = "🌴 Nature"
        static let food = "🍔 Food"
        static let art = "🎨 Art"
        static let history = "📜 History"
        static let fashion = "👗 Fashion"
        static let covid19 = "😷 Covid-19"
        static let middleEast = "⚔️ Middle East"
    }
    
    struct BrandColors {
        static let purpleDark = "BrandPurpleDark"
        static let purpleLight = "BrandPurpleLight"
        static let purplePrimary = "BrandPurplePrimary"
        static let purpleLighter = "BrandPurpleLighter"
        
        static let blackDark = "BrandBlackDark"
        static let blackLight = "BrandBlackLight"
        static let blackPrimary = "BrandBlackPrimary"
        static let blackLighter = "BrandBlackLighter"
        
        static let greyDark = "BrandGreyDark"
        static let greyLight = "BrandGreyLight"
        static let greyPrimary = "BrandGreyPrimary"
        static let greyLighter = "BrandGreyLighter"
    }

    struct Onboarding {
        static let titleNext = "Next"
        static let titleGetStarted = "Get Started"

        // Relative sizez
        static var topMarginCollectionView: CGFloat { K.screenHeight * (120 / 812) }
        static var heightCollectionView: CGFloat { K.screenHeight * (336 / 812) }
        static var topMarginPageControl: CGFloat { K.screenHeight * (40 / 812) }
        static var topMarginTitleLabel: CGFloat { K.screenHeight * (34 / 812) }
        static var fontSizeTitleLabel: CGFloat { K.screenWidth * (24 / 375) }
        static var topMarginDescriptionLabel: CGFloat { K.screenHeight * (24 / 812) }
        static var fontSizeDescriptionLabel: CGFloat { K.screenWidth * (16 / 375) }
        static var horizontalMarginDescriptionLabel: CGFloat { K.screenWidth * (80 / 375) }
        static var topMarginNextButton: CGFloat { K.screenHeight * ( 64 / 812) }
        static var horizontalMarginNextButton: CGFloat { K.screenWidth * (20 / 375) }
        static var bottomMarginNextButton: CGFloat { K.screenHeight * ( 50 / 812) }
        static var heightNextButton: CGFloat { K.screenHeight * ( 56 / 812) }
        static var cornerRadiusNextButton: CGFloat { K.screenHeight * ( 12 / 812) }
        static var fontSizeNextButton: CGFloat { K.screenWidth * (16 / 375) }
    }
}
