# iTunesSearch

This is my coding challenge for Krikey.

I enjoy learning new APIs, especially when they have thorough documentation.
Thorough documentation isn't always the case though, one can dream...
The iTunesSearchAPI is relatively straight forward in what you need to construct a query.  As I dove further in I discovered that this API is pretty hated due to the strangeness of query parameters.  I then looked for a wrapper class that would help me traverse the data easier.  I came upon one that I liked, but in the end decided not to use it.  Thus, why my project has a Pods directory but I don't use it. 

The tradeoff was that while learning a new API I would also need to learn how to implement a third-party wrapper class.  This would have taken too much of my time, and it did in the beginning.

When thinking about design patterns I decided to follow the MVP pattern, Model-View-Presenter.  I make use of this pattern on a daily basis and find it useful to separate business logic, in the presenter, from UI elements, in the view controller.  It also helps when writing tests.  Tests can be written just for the presenter.

I am a large fan of extensions especially pertaining to delegates.  I also wrote a UIImageView extension that downloads an image from a URL string.

Thank you for the opportunity!

P.S. To compile and run the project, it will need to be opened from .xcworkspace file.

