import UIKit

final class VerticalProgressBar: UIView {
    
    // MARK: - UI Components
    
    private let progressLayer = CALayer()
    
    var progress: Float = 0 {
        didSet {
            updateProgress()
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgress()
    }
}

// MARK: - Setup layers

private extension VerticalProgressBar {
    
    private func setupLayers() {
        layer.cornerRadius = 2
        layer.masksToBounds = true
        backgroundColor = .systemGray6
        
        progressLayer.backgroundColor = UIColor.systemBlue.cgColor
        layer.addSublayer(progressLayer)
    }
}

// MARK: - Update progress

private extension VerticalProgressBar {
    
    private func updateProgress() {
        let height = bounds.height * CGFloat(progress)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        progressLayer.frame = CGRect(
            x: 0,
            y: bounds.height - height,
            width: bounds.width,
            height: height
        )
        CATransaction.commit()
    }
}
