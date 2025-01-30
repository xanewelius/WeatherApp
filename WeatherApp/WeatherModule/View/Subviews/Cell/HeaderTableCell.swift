import UIKit
import SnapKit

final class HeaderTableCell: UITableViewCell {
    
    // MARK: - ID
    
    static let cellID = "HeaderCell"
    
    // MARK: - UI Components
    
    private let cityNameLabel = UILabel(frame: .zero)
    private let weatherDescriptionLabel = UILabel(frame: .zero)
    private let dataLabel = UILabel(frame: .zero)
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityNameLabel.text = nil
        weatherDescriptionLabel.text = nil
        dataLabel.text = nil
    }
}

// MARK: - Setup UI

private extension HeaderTableCell {
    
    func setupUI() {
        embedViews()
        setupStackAppearance()
        setupLayout()
        setupAppearance()
    }
}

// MARK: - Embed views

private extension HeaderTableCell {
    
    func embedViews() {
        [
            cityNameLabel,
            weatherDescriptionLabel,
            dataLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Setup stack appearance

private extension HeaderTableCell {
    
    func setupStackAppearance() {}
}

// MARK: - Setup layout

private extension HeaderTableCell {
    
    func setupLayout() {
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(32)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().inset(4)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().inset(32)
        }
    }
}

// MARK: - Setup appearance

private extension HeaderTableCell {
    
    func setupAppearance() {
        contentView.backgroundColor = .systemBackground
        
        cityNameLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .bold)
        cityNameLabel.textColor = .label
        
        weatherDescriptionLabel.font = .monospacedSystemFont(ofSize: 12, weight: .light)
        weatherDescriptionLabel.textColor = .secondaryLabel
        
        dataLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .medium)
        dataLabel.textColor = .label
    }
}

// MARK: - Set data

extension HeaderTableCell {
    
    func set(with weather: DisplayHeader) {
        cityNameLabel.text = weather.cityName
        weatherDescriptionLabel.text = weather.weatherDescription
        dataLabel.text = weather.formattedDate
    }
}
