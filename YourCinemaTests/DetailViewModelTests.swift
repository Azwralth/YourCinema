//
//  DetailViewModelTests.swift
//  YourCinemaTests
//
//  Created by Владислав Соколов on 20.02.2025.
//

//import XCTest
//@testable import YourCinema
//
//final class DetailViewModelTests: XCTestCase {
//    
//    // MARK: - Properties
//    
//    private var mockRepository: MockImageRepository!
//    private var viewModel: DetailViewModel!
//    
//    // MARK: - Setup & Teardown
//    
//    override func setUp() {
//        super.setUp()
//        mockRepository = MockImageRepository()
//        viewModel = DetailViewModel(movieDetailUseCase: mockRepository)
//    }
//    
//    override func tearDown() {
//        mockRepository = nil
//        viewModel = nil
//        super.tearDown()
//    }
//    
//    // MARK: - Success Tests
//    
//    func testFetchImageSuccess() async {
//        // Given
//        let testData = UIImage(systemName: "photo")!.pngData()!
//        mockRepository.mockResult = .success(testData)
//        let validURL = "https://image.openmoviedb.com/kinopoisk-images/1599028/637271d5-61b4-4e46-ac83-6d07494c7645/orig"
//        
//        // When
//        await viewModel.fetchImage(from: validURL)
//        
//        // Then
//        XCTAssertNotNil(viewModel.image)
//        XCTAssertNil(viewModel.error)
//        XCTAssertEqual(mockRepository.lastReceivedURL, URL(string: validURL))
//    }
//    
//    // MARK: - Error Handling Tests
//    
//    func testFetchImageClientError() async {
//        // Given
//        mockRepository.mockResult = .failure(NetworkError.clientError(404))
//        let validURL = "https://image.openmoviedb.com/kinopoisk-images/1599028/637271d5-61b4-4e46-ac83-6d07494c7645/orig"
//        
//        // When
//        await viewModel.fetchImage(from: validURL)
//        
//        // Then
//        XCTAssertNil(viewModel.image)
//        XCTAssertEqual(viewModel.error, .clientError(404))
//    }
//    
//    func testFetchImageServerError() async {
//        // Given
//        mockRepository.mockResult = .failure(NetworkError.serverError(500))
//        let validURL = "https://example.com/server-error.jpg"
//        
//        // When
//        await viewModel.fetchImage(from: validURL)
//        
//        // Then
//        XCTAssertNil(viewModel.image)
//        XCTAssertEqual(viewModel.error, .serverError(500))
//    }
//    
//    func testFetchImageUnknownError() async {
//        // Given
//        mockRepository.mockResult = .failure(NSError(domain: "Test", code: 0))
//        let validURL = "https://example.com/unknown-error.jpg"
//        
//        // When
//        await viewModel.fetchImage(from: validURL)
//        
//        // Then
//        XCTAssertNil(viewModel.image)
//        XCTAssertEqual(viewModel.error, .unknownError(0))
//    }
//    
//    // MARK: - Validation Tests
//    
//    func testFetchImageInvalidURL() async {
//        // Given
//        let invalidURL = "not-valid-url"
//        
//        // When
//        await viewModel.fetchImage(from: invalidURL)
//        
//        // Then
//        XCTAssertNil(viewModel.image)
//        XCTAssertEqual(viewModel.error, .invalidUrl)
//        XCTAssertNil(mockRepository.lastReceivedURL)
//    }
//}
//
//// MARK: - Mock Classes
//
//final class MockImageRepository: ImageRepository {
//    enum MockError: Error {
//        case resultNotSet
//    }
//    
//    var mockResult: Result<Data, Error>?
//    var lastReceivedURL: URL?
//    
//    func fetchImage(from url: URL) async throws -> Data {
//        lastReceivedURL = url
//        switch mockResult {
//        case .success(let data):
//            return data
//        case .failure(let error):
//            throw error
//        case .none:
//            throw MockError.resultNotSet
//        }
//    }
//}
