import UIKit
import SnapKit

final class HumidityTableCell: UITableViewCell {
    
    // MARK: - ID
    
    static let cellID = "VisibilityCell"
    
    // MARK: - UI Components
    
    private let humidityLabel = UILabel(frame: .zero)
    private let progressBar = UIProgressView(frame: .zero)
    
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
        
        humidityLabel.text = nil
        progressBar.progress = 0
    }
}

// MARK: - Setup UI

private extension HumidityTableCell {
    
    func setupUI() {
        embedViews()
        setupStackAppearance()
        setupLayout()
        setupAppearance()
    }
}

// MARK: - Embed views

private extension HumidityTableCell {
    
    func embedViews() {
        [
            humidityLabel,
            progressBar
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Setup stack appearance

private extension HumidityTableCell {
    
    func setupStackAppearance() {}
}

// MARK: - Setup layout

private extension HumidityTableCell {
    
    func setupLayout() {
        humidityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(32)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}

// MARK: - Setup appearance

private extension HumidityTableCell {
    
    func setupAppearance() {
        contentView.backgroundColor = .systemBackground
        
        humidityLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .medium)
        humidityLabel.textColor = .label
        
        progressBar.layer.cornerRadius = 8
        progressBar.clipsToBounds = true
    }
}

// MARK: - Set data

extension HumidityTableCell {
    
    func set(with weather: DisplayHumidity) {
        humidityLabel.text = weather.humidity
        progressBar.progress = weather.progress
    }
}
