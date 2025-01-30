import UIKit
import SnapKit
import Kingfisher

final class WeatherViewController: UIViewController, WeatherView {
    
    // MARK: - Connections
    
    var output: WeatherViewOutput!
    
    // MARK: - UI Components
    
    private let searchBar = UISearchBar(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tableViewDataSource = WeatherTableDataSource()
    private let errorView = ErrorView(frame: .zero)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output.viewDidLoad()
    }
}

// MARK: - Setup UI

private extension WeatherViewController {
    
    func setupUI() {
        embedViews()
        setupLayout()
        setupBehavior()
        setupAppearance()
        setupNavigation()
    }
}

extension WeatherViewController {
    
    func setupNavigation() {
        searchBar.delegate = self
        searchBar.placeholder = "Search city"
        navigationItem.titleView = searchBar
    }
}

// MARK: - Embed views

private extension WeatherViewController {
    
    func embedViews() {
        [
            imageView,
            tableView,
            errorView,
            activityIndicator
        ].forEach {
            view.addSubview($0)
        }
    }
}

// MARK: - Setup layout

private extension WeatherViewController {
    
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Setup behavior

private extension WeatherViewController {
    
    func setupBehavior() {
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        
        tableView.register(HeaderTableCell.self, forCellReuseIdentifier: HeaderTableCell.cellID)
        tableView.register(TimeTableCell.self, forCellReuseIdentifier: TimeTableCell.cellID)
        tableView.register(MainInfoTableCell.self, forCellReuseIdentifier: MainInfoTableCell.cellID)
        tableView.register(HumidityTableCell.self, forCellReuseIdentifier: HumidityTableCell.cellID)
        
        errorView.onRetry = { [weak self] in
            guard let text = self?.searchBar.text else { return }
            self?.output.searchWeather(for: text)
        }
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
        errorView.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - Setup appearance

private extension WeatherViewController {
    
    func setupAppearance() {
        view.backgroundColor = .systemBackground
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
    }
}

// MARK: - UISearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        animateCancelButton(searchBar, show: false)
        searchBar.resignFirstResponder()
        output.searchWeather(for: text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animateCancelButton(searchBar, show: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        animateCancelButton(searchBar, show: false)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    private func animateCancelButton(_ searchBar: UISearchBar, show: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            searchBar.showsCancelButton = show
            searchBar.layoutIfNeeded()
        })
    }
}

// MARK: - UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - WeatherViewInput

extension WeatherViewController {
    
    func set(state: WeatherViewState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            errorView.isHidden = true
            imageView.isHidden = true
            tableView.isHidden = true
        case .success:
            searchBar.text = ""
            activityIndicator.stopAnimating()
            errorView.isHidden = true
            imageView.isHidden = false
            tableView.isHidden = false
        case .error(let description):
            activityIndicator.stopAnimating()
            errorView.isHidden = false
            imageView.isHidden = true
            tableView.isHidden = true
            //updateErrorState(message: description)
        }
    }
    
    func updateWeather(_ weather: Weather) {
        tableViewDataSource.update(with: weather)
        tableView.reloadData()
    }
}

// MARK: - Update error state

private extension WeatherViewController {
    
    func updateErrorState(message: String) {
        let label = UILabel()
        label.text = message
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        
        errorView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
