import Foundation
import Crashlytics

enum AnalyticsProductEvent
{
    case payBasket(success: Bool)
    case addToBasket(success: Bool)
    case removeFromBasket(success: Bool)
    case presentProductsList
    case presentProduct(contentType: String,
                        contentId: String)
}

protocol ProductTrackableMixin
{
    func track(_ event: AnalyticsProductEvent)
}

extension ProductTrackableMixin
{
    func track(_ event: AnalyticsProductEvent)
    {
        switch event
        {
        case let .payBasket(success):
            Answers.logCustomEvent(withName: "Pay basket", customAttributes: ["success": success ])
        case let .addToBasket(success):
            Answers.logCustomEvent(withName: "Add to basket", customAttributes: ["success": success ])
        case let .removeFromBasket(success):
            Answers.logCustomEvent(withName: "Remove from basket", customAttributes: ["success": success ])
        case .presentProductsList:
            Answers.logContentView(withName: "Present goods", contentType: nil, contentId: nil, customAttributes: nil)
        case let .presentProduct(contentType, contentId):
            Answers.logContentView(withName: "Present product", contentType: contentType, contentId: contentId, customAttributes: nil)
        }
    }
}
