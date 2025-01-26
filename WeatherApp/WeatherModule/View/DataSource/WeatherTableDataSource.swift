import UIKit

final class WeatherTableDataSource: NSObject, UITableViewDataSource {
    
    private enum Section: Int, CaseIterable {
        case header
        case time
        case weather
        case humidity
    }
    
    private var weather: Weather?
    
    func update(with weather: Weather) {
        self.weather = weather
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableCell.cellID, for: indexPath) as? HeaderTableCell else { return UITableViewCell() }
            if let weather = weather {
                cell.set(with: WeatherMapper.mapToDisplayHeader(from: weather))
            }
            return cell
        case .time:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableCell.cellID, for: indexPath) as? TimeTableCell else { return UITableViewCell() }
            if let weather = weather {
                cell.set(with: WeatherMapper.mapToDisplayTime(from: weather))
            }
            return cell
        case .weather:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainInfoTableCell.cellID, for: indexPath) as? MainInfoTableCell else { return UITableViewCell() }
            if let weather = weather {
                cell.set(with: WeatherMapper.mapToWeatherItem(from: weather))
            }
            return cell
        case .humidity:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HumidityTableCell.cellID, for: indexPath) as? HumidityTableCell else { return UITableViewCell() }
            if let weather = weather {
                cell.set(with: WeatherMapper.mapToDisplayHumidity(from: weather))
            }
            return cell
        }
    }
}
