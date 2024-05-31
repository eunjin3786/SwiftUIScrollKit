# SwiftUIScrollKit

SwiftUIScrollKit helps you easily use scroll-related components in SwiftUI. 📜



## Basic Scroll Components

SwiftUI scroll components don't provide their scroll offset.
You can easily know it with this components.



### 1️⃣ ScrollViewWithOffset

You can read scroll offset of [ScrollView](https://developer.apple.com/documentation/swiftui/scrollview)

| horizontal | vertical |
| ------- | ------- |
| ![ezgif-4-aca504d627](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/ef9a045d-894c-4c8c-9e5c-96ca624d65a2)   | ![ezgif-4-8cc02a8fa1](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/cbbdc665-531b-48e2-a76d-d11a6f75ff5c) |



```swift
struct ContentView: View {
    
    var body: some View {
        ScrollViewWithOffset(
            items: [
                Color.red.frame(width: 500, height: 500),
                Color.green.frame(width: 500, height: 500),
                Color.yellow.frame(width: 500, height: 500),
            ],
            direction: .vertical,
            onOffsetChanged: {
                // you can do something with offset
            }
        )
    }
}
```




### 2️⃣ PageStyleTabViewWithOffset


You can read scroll offset of PageStyle [TabView](https://developer.apple.com/documentation/swiftui/tabview)

*It only gives offset within one page. 
If you want to know whole scroll offset, you can use [FullCarousel](#2️⃣-fullcarousel)*


![ezgif-4-b3dd87e262](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/c17d7bc4-364b-4314-91ac-f58ebea3e215)

```swift
struct ContentView: View {
    
    @State private var currentPage: Int = 0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        PageStyleTabViewWithOffset(
            items: [
                Color.red,
                Color.green,
                Color.yellow
            ],
            onCurrentPageChanged: {
                currentPage = $0
            },
            onOffsetChanged: {
                offset = $0
            }
        )
    }
}
```









## Advanced Scroll Components

You can also use various types of scroll components.


### 1️⃣ CenteredCarousel

![ezgif-4-1ff327f849](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/6f37e2cf-650d-47db-9fcd-9f1fc79c3d7a)

```swift
struct ContentView: View {
    
    @State var currentPage: Int = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        CenteredCarousel(
            items: [
                Color.red,
                Color.green,
                Color.orange,
                Color.blue
            ],
            pagerWidth: UIScreen.main.bounds.width,
            sectionPadding: 50,
            cardPadding: 20,
            height: 300,
            onCurrentPageChanged: {
                currentPage = $0
            },
            onOffsetChanged: {
                offset = $0
            }
        )
    }
}
```

### 2️⃣ FullCarousel

![ezgif-4-ef62bd17f8](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/b030bcd8-4742-4968-951d-b93075ef5140)


```swift
struct ContentView: View {
    
    @State var currentPage: Int = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        FullCarousel(
            items: [
                Color.red,
                Color.green,
                Color.orange,
                Color.blue
            ],
            itemSize: CGSize(width: UIScreen.main.bounds.width, height: 400),
            onCurrentPageChanged: {
                currentPage = $0
            },
            onOffsetChanged: {
                offset = $0
            }
        )
    }
}
```


### 3️⃣ RatioCarousel

you can set the ratio you want to scroll with this.

![ezgif-1-39ba2cddb8](https://github.com/eunjin3786/SwiftUIScrollKit/assets/9502063/64f21e86-5f6f-4f39-b61f-2175716679b9)

```swift
struct ContentView: View {
    
    @State var currentPage: Int = 0
    @State var offset: CGFloat = 0
    
    var body: some View {
        RatioCarousel(
            items: [
                Color.red,
                Color.green,
                Color.orange,
                Color.blue
            ].map { $0.padding(.horizontal, 5) },
            itemSize: CGSize(width: 300, height: 400),
            scrollRatio: 0.7,
            onCurrentPageChanged: {
                currentPage = $0
            },
            onOffsetChanged: {
                offset = $0
            }
        )
    }
}
```

## Requirements

- iOS 15.0+
- Swift 5.9+

## Installation

### Swift Package Manager

You can install SwiftUIScrollKit using Swift Package Manager. Simply add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/eunjin3786/SwiftUIScrollKit.git", from: "1.0.0")
]

