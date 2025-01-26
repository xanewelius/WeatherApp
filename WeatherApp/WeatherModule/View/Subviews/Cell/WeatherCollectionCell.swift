import UIKit
import SnapKit

final class WeatherCollectionCell: UICollectionViewCell {
    
    // MARK: - ID
    
    static let cellID = "TimeCell"
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel(frame: .zero)
    private let infoLabel = UILabel(frame: .zero)
    private let progressBar = VerticalProgressBar(frame: .zero)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        infoLabel.text = nil
        progressBar.progress = 0
    }
}

// MARK: - Setup UI

private extension WeatherCollectionCell {
    func setupUI() {
        embedViews()
        setupStackAppearance()
        setupLayout()
        setupAppearance()
    }
}

// MARK: - Embed views

private extension WeatherCollectionCell {
    
    func embedViews() {
        [
            titleLabel,
            infoLabel,
            progressBar
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Setup stack appearance

private extension WeatherCollectionCell {
    
    func setupStackAppearance() {}
}

// MARK: - Setup layout

private extension WeatherCollectionCell {
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Setup appearance

private extension WeatherCollectionCell {
    
    func setupAppearance() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        
        infoLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        infoLabel.textColor = .label
    }
}

// MARK: - Set data

extension WeatherCollectionCell {
    
    func set(item: DisplayMainInfo) {
        titleLabel.text = item.name
        infoLabel.text = item.info
        progressBar.progress = item.progress
    }
}
