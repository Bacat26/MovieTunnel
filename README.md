# MovieTunnel

MovieTunnel is an iOS application that lists movies. You can add movies to favorite list. You can also examine in environments where the internet is not available.


## Screenshoots

![ScreenshootMovieTunnel-1](https://user-images.githubusercontent.com/21208125/168098301-21f8e649-bd78-4bfc-bb84-3e42617449b5.png)
![sscreenshootMovieTunnel-2](https://user-images.githubusercontent.com/21208125/168098311-2e9f69e5-3ec6-489b-94fb-0096e5886aa9.png)
![sscreenshootMovieTunnel-4](https://user-images.githubusercontent.com/21208125/168098281-78740fae-d241-459a-a9cb-53ea01600ec9.png)

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
