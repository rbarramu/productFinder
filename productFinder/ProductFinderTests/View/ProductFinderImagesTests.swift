@testable import ProductFinder
import UIKit
import XCTest

class ProductFinderImagesTests: TestCase {
    let renderedAsTemplate = ["icon-phone"]

    let names: [String: UIImage] = [
        "icon-placeholder-lemon": ProductFinderImages.Icons.placeholderImage,
        "icon-error-connection": ProductFinderImages.Icons.errorConnectionImage,
        "icon-error-default": ProductFinderImages.Icons.errorDefaultImage,
        "icon-error-search": ProductFinderImages.Icons.errorSearchImage,
    ]

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testImages() {
        for (name, expected) in names {
            assert(imageName: name, expectedImage: expected)
        }
    }

    private func assert(imageName named: String, expectedImage: UIImage) {
        guard let image = UIImage(named: named) else {
            XCTFail("Image with name '\(named)' not found")
            return
        }
        let representation = renderedAsTemplate.contains(named) ?
            image.withRenderingMode(.alwaysTemplate).pngData() : image.pngData()
        let expectedRepresentation = expectedImage.pngData()
        XCTAssertEqual(representation, expectedRepresentation, "Image with name '\(named)' not found")
    }
}
