import UIKit
import SnapKit
import Kingfisher

final class TimeTableCell: UITableViewCell {
    
    // MARK: - ID
    
    static let cellID = "TimeCell"
    
    // MARK: - UI Components
    
    private let timeLabel = UILabel(frame: .zero)
    private let weatherImageView = UIImageView(frame: .zero)
    
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
        
        timeLabel.text = nil
        weatherImageView.image = nil
        weatherImageView.kf.cancelDownloadTask()
    }
}

// MARK: - Setup UI

private extension TimeTableCell {
    
    func setupUI() {
        embedViews()
        setupStackAppearance()
        setupLayout()
        setupAppearance()
    }
}

// MARK: - Embed views

private extension TimeTableCell {
    
    func embedViews() {
        [
            timeLabel,
            weatherImageView
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Setup stack appearance

private extension TimeTableCell {
    
    func setupStackAppearance() {}
}

// MARK: - Setup layout

private extension TimeTableCell {
    
    func setupLayout() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(28)
            make.bottom.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(32)
            make.height.width.equalTo(70)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Setup appearance

private extension TimeTableCell {
    
    func setupAppearance() {
        contentView.backgroundColor = .systemBackground
        
        timeLabel.font = .boldSystemFont(ofSize: 48)
        timeLabel.textColor = .label
        
        weatherImageView.contentMode = .scaleAspectFill
        weatherImageView.clipsToBounds = true
        weatherImageView.layer.cornerRadius = 8
    }
}

// MARK: - Set data

extension TimeTableCell {
    
    func set(with weather: DisplayTime) {
        timeLabel.attributedText = weather.time
        weatherImageView.kf.setImage(
            with: weather.imageURL,
            options: [.transition(.fade(0.3)), .cacheOriginalImage]
        )
    }
}
