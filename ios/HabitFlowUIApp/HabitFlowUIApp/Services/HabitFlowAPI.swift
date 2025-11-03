import Foundation

enum HabitFlowAPIError: Error {
    case invalidBaseURL
    case invalidResponse
    case httpStatus(Int)
}

final class HabitFlowAPI {
    static let shared = HabitFlowAPI()

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        baseURL: URL? = nil,
        session: URLSession = .shared
    ) {
        if let baseURL {
            self.baseURL = baseURL
        } else if
            let env = ProcessInfo.processInfo.environment["HABITFLOW_API_BASE_URL"],
            let envURL = URL(string: env.trimmingCharacters(in: .whitespacesAndNewlines))
        {
            self.baseURL = envURL
        } else {
            self.baseURL = URL(string: "http://localhost:8080")!
        }

        self.session = session

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
    }

    func fetchTodayDashboard(userId: Int = 1) async throws -> TodayDashboardPayload {
        try await request(path: "/api/v1/dashboard/today", userId: userId)
    }

    func fetchCoachDashboard(userId: Int = 1) async throws -> CoachDashboardPayload {
        try await request(path: "/api/v1/dashboard/coach", userId: userId)
    }

    func fetchLogDashboard(userId: Int = 1) async throws -> LogDashboardPayload {
        try await request(path: "/api/v1/dashboard/log", userId: userId)
    }

    func fetchWeeklyDashboard(userId: Int = 1) async throws -> WeeklyDashboardPayload {
        try await request(path: "/api/v1/dashboard/weekly", userId: userId)
    }

    func fetchProfileDashboard(userId: Int = 1) async throws -> ProfileDashboardPayload {
        try await request(path: "/api/v1/profile", userId: userId)
    }

    private func request<T: Decodable>(path: String, userId: Int) async throws -> T {
        guard let url = makeURL(path: path, userId: userId) else {
            throw HabitFlowAPIError.invalidBaseURL
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HabitFlowAPIError.invalidResponse
        }

        guard 200 ... 299 ~= httpResponse.statusCode else {
            throw HabitFlowAPIError.httpStatus(httpResponse.statusCode)
        }

        return try decoder.decode(T.self, from: data)
    }

    private func makeURL(path: String, userId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.port = baseURL.port
        components.path = baseURL.path + path
        components.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        return components.url
    }
}
