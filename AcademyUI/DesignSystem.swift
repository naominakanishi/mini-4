import CoreGraphics
import SwiftUI

private let isPhone = UIDevice.current.userInterfaceIdiom == .phone

public enum DesignSystem {
    public enum Spacing {
        public static let generalHPadding: CGFloat = 24
        public static let titleToContentPadding: CGFloat = 24
        public static let logoToContentPadding: CGFloat = 32
        public static let cardInternalPadding: CGFloat = 8
        public static let cardInternalContentPadding: CGFloat = 4
        public static let subtitlesToContentPadding: CGFloat = 8
        public static let listIntraCardsPadding: CGFloat = 12
        
        //MARK: TV Spacing:
        
        public static let tvCardInternalPadding: CGFloat = 24
    }
 
}

public extension Font {
    static var adaFontSubtitle: Font {
        if isPhone {
            return .system(size: 20, weight: .bold)
        }
        return .tvTitle
    }
    static let adaFontUtilsCards: Font = .system(size: 16, weight: .bold)
    static let cardTitle: Font = .system(size: 16, weight: .bold)
    static let cardText: Font = .system(size: 15, weight: .regular)
    static let helpItemPosition: Font = .system(size: 20, weight: .bold)
    static let listItemTitle: Font = .system(size: 15, weight: .bold)
    static let listItemSubcontent: Font = .system(size: 12, weight: .regular)
    static let listItemTimeStamp: Font = .system(size: 15, weight: .bold)
    static var adaTagTitle: Font {
        if isPhone {
            return .system(size: 15, weight: .bold)
        }
        return .system(size: 28, weight: .bold)
    }
    static var calendarDayOfTheWeek: Font {
        if isPhone {
            return .system(size: 13, weight: .regular)
        }
        return .system(size: 24, weight: .regular)
    }
    static var calendarDayOfTheMonth: Font {
        if isPhone {
            return .system(size: 32, weight: .semibold)
        }
        return .system(size: 40, weight: .semibold)
    }
    static let sendRequestButtonLabel: Font = .system(size: 17, weight: .bold)
    
    //MARK: TV Fonts:
    static let tvTitle: Font = .system(size: 64, weight: .bold)
    static let tvAnnouncementTitle: Font = .system(size: 32, weight: .bold)
    static let tvAnnouncementContent: Font = .system(size: 24, weight: .regular)
    static let tvAnnouncementRole: Font = .system(size: 20, weight: .regular)
    
    static let tvCurrentMomentLabel: Font = .system(size: 32, weight: .regular)
    
    static let tvDayOfTheWeek: Font = .system(size: 36, weight: .regular)
    static let tvDayOfTheMohth: Font = .system(size: 72, weight: .semibold)
    static let tvEventEmoji: Font = .system(size: 48)
    static let tvEventTitle: Font = .system(size: 32, weight: .bold)
    static let tvEventTime: Font = .system(size: 30, weight: .regular)
    
}
