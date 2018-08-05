import Foundation
import Crashlytics

enum AnalyticsEvent
{
    case login(method: String, success: Bool)
    case logout
    case logSignUp(method: String, success: Bool)
    case addReview()
}

protocol TrackableMixin
{
    func track(_ event: AnalyticsEvent)
}

extension TrackableMixin
{
    func track(_ event: AnalyticsEvent)
    {
        switch event
        {
        case let .login(method, success):
            let success = NSNumber(value: success)
            Answers.logLogin(withMethod: method, success: success, customAttributes: nil)
        case .logout:
            Answers.logCustomEvent(withName: "logout", customAttributes: [:])
        case let .logSignUp(method, success):
            let success = NSNumber(value: success)
            Answers.logSignUp(withMethod: method, success: success, customAttributes: nil)
        case .addReview:
            Answers.logCustomEvent(withName: "Add review", customAttributes: [  : ])
        }
    }
}
