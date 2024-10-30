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
        static var topMarginStackView: CGFloat { K.screenHeight * (34 / 812) }
        static var horizontalMarginStackView: CGFloat { K.screenWidth * (80 / 375) }
        static var spacingStackView: CGFloat { K.screenWidth * (24 / 375) }
        static var fontSizeTitleLabel: CGFloat { K.screenWidth * (24 / 375) }
        static var fontSizeDescriptionLabel: CGFloat { K.screenWidth * (16 / 375) }
        static var topMarginNextButton: CGFloat { K.screenHeight * ( 64 / 812) }
        static var horizontalMarginNextButton: CGFloat { K.screenWidth * (20 / 375) }
        static var heightNextButton: CGFloat { K.screenHeight * ( 56 / 812) }
        static var cornerRadiusNextButton: CGFloat { K.screenHeight * ( 12 / 812) }
        static var fontSizeNextButton: CGFloat { K.screenWidth * (16 / 375) }
        static var cornerRadiusImage: CGFloat { K.screenHeight * ( 12 / 812) }
    }

    struct Authorization {
        static let loginTitle: String = "Welcome Back 👋"
        static let loginDescription: String = "I am happy to see you again. You can continue where you left off by logging in"
        static let registerTitle: String = "Welcome to NewsToDay"
        static let registerDescription: String = "Hello, I guess you are new around here. You can start using the application after sign up."
        static let placeholderEmail: String = "Email"
        static let placeholderPassword: String = "Password"
        static let placeholderRepeatPassword: String = "Repeat Password"
        static let placeholderName: String = "Username"
        static let signInButtonTitle: String = "Sign In"
        static let signUpButtonTitle: String = "Sign Up"
        static let signInLabel: String = "Already have an account?"
        static let signUpLabel: String = "Don't have an account?"

        // Relative sizez
        static var fontSizeTitleLabel: CGFloat { K.screenWidth * (24 / 375) }
        static var fontSizeDescriptionLabel: CGFloat { K.screenWidth * (16 / 375) }
        static var cornerRadiusSignButton: CGFloat { K.screenHeight * (12 / 812) }
        static var spacingStackView: CGFloat { K.screenWidth * (5 / 375) }
        static var fontSizeSign: CGFloat { K.screenWidth * (16 / 375) }
        static var topMarginTitleLabel: CGFloat { K.screenHeight * (72 / 812) }
        static var topMarginDescriptionLabel: CGFloat { K.screenHeight * ( 8 / 812) }
        static var horizontalMarginTwenty: CGFloat { K.screenWidth * (20 / 375) }
        static var topMarginUpperTextField: CGFloat { K.screenHeight * (32 / 812) }
        static var topMarginInteriorTextField: CGFloat { K.screenHeight * (16 / 812) }
        static var heightTextField: CGFloat { K.screenHeight * (56 / 812) }
        static var topMarginSignButton: CGFloat { K.screenHeight * (64 / 812) }
        static var heightSignButton: CGFloat { K.screenHeight * (56 / 812) }
        static var bottomMarginStackView: CGFloat { K.screenHeight * (42 / 812) }
        static var rightMarginToggleButton: CGFloat { K.screenWidth * (16 / 375) }
        static var heightToggleButton: CGFloat { K.screenHeight * (24 / 812) }
    }
}
