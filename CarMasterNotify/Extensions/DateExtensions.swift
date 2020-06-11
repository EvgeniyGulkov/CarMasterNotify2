extension Date {
    func midnightDate() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    func formatted(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
