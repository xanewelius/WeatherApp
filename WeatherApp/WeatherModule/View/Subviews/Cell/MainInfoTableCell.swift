import UIKit
import SnapKit

final class MainInfoTableCell: UITableViewCell {
    
    // MARK: - ID
    
    static let cellID = "WeatherCell"
    
    // MARK: - UI Components
    
    private var weatherItems: [WeatherItem] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.clipsToBounds = true
        return collectionView
    }()
    
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
        weatherItems.removeAll()
        collectionView.reloadData()
    }
}

// MARK: - Setup UI

private extension MainInfoTableCell {
    
    func setupUI() {
        embedViews()
        setupStackAppearance()
        setupLayout()
        setupBehavior()
        setupAppearance()
    }
}

// MARK: - Embed views

private extension MainInfoTableCell {
    
    func embedViews() {
        [
            collectionView,
        ].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Setup stack appearance

private extension MainInfoTableCell {
    
    func setupStackAppearance() {}
}

// MARK: - Setup layout

private extension MainInfoTableCell {
    
    func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            
            make.height.equalTo(222)
        }
    }
}

// MARK: - Setup behavior

private extension MainInfoTableCell {
    func setupBehavior() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionCell.self, forCellWithReuseIdentifier: WeatherCollectionCell.cellID)
    }
}

// MARK: - Setup appearance

private extension MainInfoTableCell {
    
    func setupAppearance() {
        contentView.backgroundColor = .systemBackground
    }
}

// MARK: - Set data

extension MainInfoTableCell {
    
    func set(with weatherItem: [WeatherItem]) {
        self.weatherItems = weatherItem
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension MainInfoTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.cellID, for: indexPath) as? WeatherCollectionCell else {
            return UICollectionViewCell()
        }
        
        let item = weatherItems[indexPath.item]
        cell.set(item: DisplayMainInfo(
            name: item.name,
            info: item.info,
            progress: item.progress
        ))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainInfoTableCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainInfoTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (contentView.frame.width - 32) / 2, height: 74)
    }
}
