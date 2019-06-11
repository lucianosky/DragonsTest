# DragonsTest
This is a Dragons API Test App

# Architecture
- The app is implemented with the MVVM architecture.
- The app is an implementation of the Clean Architecture. Implementation started with the upper layers, following down to the UI. So, unit testing was keeping the correct flow during development. That's why the UI was left for last (and the Router for later).
- Clean Code was also pursuit.
- Since the app is very simple, and the API is a single fixed result, data binding was not implemented yet. 
- Unit test was implemented with the use of Quick and Nimble for behaviour style testing, but TDD was not used in this project (test were written after the methods).
- To create the UI the VFL (Visual Format Language) was used, which avoids the usage of Storyboards, with the advantages of quicker and simpler code and reduction of merge conflicts possibilities.

# Dependencies
- It was a decision to keep the app as simple as possible, according to the KISS principle. This includes leaving out some popular frameworks that offer little to the current capabilities of the language.
- Cocoapods was used.
- The only frameworks used were Quick and Nimble.
- Alamofire was left out in favor of using native resources to call for HTTP verbs.
- Kingfisher was left out in favor of using native resources to download images from the web.
- RxSwift was left out. Although this discussion is out of scope of this project, native closures can offer the same reactive advantages where the signals are not complex (for example, in an API call).

# To Do List
## Due to limitations in time several aspects were left to be done in the near future:
- DragonsListViewController.cellForRowAt -> refactor call to DragonListViewModel.getDragonImage -> rename to willShowDragon
    - also create dictionary to work as cache for downloaded images
    - after that complete the DragonListViewModelTests
    - and after cover ViewController with tests
- WIP: (temporary) Strings as Consts in classes
- Change app name to Dracarys!
- User interface was implemented last. There's poor UX at this moment. The tableView could be changed by a slider. The dragon image should be shown in a second scene with a full size image, along with other Dragon's properties. Colors need to be improved.
- Error messages are not popping yet on the View Controller, although this should be easy since events are flowing down to the VC.
- Current API does not make possible to change alert button visual properties. A new interface should be made for the dragon sound for bigger impact. Perhaps playing also a sound.
- Create routers: Each scene will be reference by a specific Router. Routers will be included in unit testing.
- Data binding will be implemented with the use of closures. A test button could be implemented on the Navigation Bar to simulate data update, URL can be callled again and data refresh down to the View Controller.
- Change DragonResult to native Result on Swift 5.
- LogHelper: log on FireBase
- Replace strings consts in each class

# Unit Test
- WIP - Missing Unit Tests
- Coverage at this point is 48%. It should be noted that it was over 60% during most development, but later it was left behind. 
- ViewController does not include unit test coverage yet.
- A couple of methods were included in ViewModel and Model, they need unit test coverage.
- DataService class was not included in unit tests. It should receive a wrapper of the URLSession class, therefore could have its own behaviour tested (it really should).
- Some important classes have 100% coverage, other important classes lost it later in the implementation (main classes from each layer). This will be fixed.

# Notes
- Core Data was included on project for a future feature of saving a favourite Dragon.
- Keeping Pods on GitHub is subject of debate in the community, in this project the decision was to keep them.
