# MovieTunnel

MovieTunnel is an iOS application that lists movies. You can add movies to favorite list. You can also examine in environments where the internet is not available.
<br /> <br />

## Screenshoots
![as2](https://user-images.githubusercontent.com/21208125/168105460-044008d9-9e85-46c9-807a-a8b5715efee7.png)
![as3](https://user-images.githubusercontent.com/21208125/168105518-7bfeec1a-ac3f-49b7-8714-85c3db8f1293.png)
![as1](https://user-images.githubusercontent.com/21208125/168105411-f97d7299-a8fb-46ef-b042-02da6fe66f29.png)

<br /> <br />

## 👨🏻‍💻 Architecture

MovieTunnel was designed using MVVM architecture as a design pattern. I developed by protocol oriantation rules and SOLID princibles as much as possible. All ViewModels has a protocol. You can see ability of Viewmodels on Protocols. Page designs were generally made with tableViews and CollectionView in order to have a responsive design. 
<br /> <br />
## 📦 Dependencies & Pods <br /> 

:open_file_folder: <ins>Alamofire ~> 5.0:</ins>  <br />
<br />
Alamofire is an HTTP networking library written in Swift. I used for service method call. <br />
It used just at Network Layer. <br />
<br />
:open_file_folder: <ins>Kingfisher ~> 7.0</ins>  <br />
<br />
Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. <br />
<br />
:open_file_folder: <ins>Default</ins> <br />
<br />
Default is a library that extends what UserDefaults can do by providing extensions for saving custom objects that conform to Codable and also providing a new interface to UserDefaults <br />
I used for favorite list save and fetch functions.
<br />
