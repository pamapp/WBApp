//
//  AsyncImageView.swift
//  WBApp
//
//  Created by Alina Potapova on 27.07.2024.
//

import SwiftUI

public struct AsyncImageView<Content>: View where Content: View {
    public typealias Phase = ImageLoader.State

    @StateObject private var imageLoader: ImageLoader
    @State private var imageOpacity: Double = 0
    
    private let content: (Phase) -> Content

    public init<P>(
        url: URL?,
        @ViewBuilder content: @escaping (Phase) -> P
    ) where Content == AnyView, P: View {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
        self.content = { phase in AnyView(content(phase)) }
    }
    
    public var body: some View {
        content(imageLoader.state)
            .transition(.opacity)
    }
}

extension AsyncImageView {
    public class ImageLoader: ObservableObject {
        @Published public private(set) var state: State = .loading

        public enum Error: Equatable {
            case dataError
            case urlError
            case taskError(URLError)
        }
        
        public enum State: Equatable {
            case loading
            case success(Image)
            case failed(Error?)
        }
        
        public init(url: URL?) {
            loadImage(from: url)
        }
    
        private func loadImage(from url: URL?) {
            guard let url = url else {
                self.state = .failed(.urlError)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }

                if let error = error as? URLError {
                    DispatchQueue.main.async {
                        self.state = .failed(.taskError(error))
                    }
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.state = .failed(.dataError)
                    }
                    return
                }
                
                // Для имитации загрузки откладываем на 0.3 секунды
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        self.state = .success(Image(uiImage: image))
                    }
                }
            }
            task.resume()
        }
    }
}
   
