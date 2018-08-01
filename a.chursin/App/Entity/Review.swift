// Структуры хранящие результаты запросов по отзывам
import Foundation

struct ReviewAddResult: Codable
{
    let result: Int
    let userMessage: String
}

struct RemoveReviewResult: Codable
{
    let result: Int
}

struct ApproveReviewResult: Codable
{
    let result: Int
}
