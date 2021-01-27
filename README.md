# TheFork-TechnicalCase

TheFork-TechnicalCase is a project written in with a MVP + Coordinator approach, as exercise for an interview on TheFork.

## Project guidelines

- [x] Write the application in **Swift**
- [x] Use iOS 11 SDK as Target
- [x] You must use a **UICollectionView**
- [x] The UI must be created without the use of Xib or Storyboard
- [x] Restaurant data are accessible on this [JSON file](https://ptitchevreuil.github.io/test.json) (mock)

## Evaluation criteria

- Your test compiles and run
- Your implementation can easily be understood by the reviewer
- Your code is testable

## Considerations

The app is created for iPhone, portrait only with no support for dark mode. 

Given the size of the project and the short time to complete the exercise, I chose to do it all with an MVP pattern.

I've chosen to now use external libraries.

The app stores images in NSCache. For now, the app only works with the network connection.

## Possible improvements

Provide support for iPhone and iPad, with all size classes. 
Provide support for dark mode.
Create a pod with all the utilities, network manager and so on. It should be versioned in order to be upgraded and reused in the future.

## Requirements

- iOS 11.0+
- Xcode 12+
- Swift 5.3+

## Credits

I DON'T own ANYTHING about assets, TheFork, TripAdvisor. This is just a test project.
