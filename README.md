# The Feed API Challenge - iOSLeadEssentials.com

![](https://github.com/essentialdevelopercom/ios-lead-essentials-feed-api-challenge/workflows/CI/badge.svg)

It's time to put your skills to the test!

You are called to implement the `RemoteFeedLoader` to load a collection of images from a backend.

Your implementation must:

1) Conform to the `<FeedLoader>` protocol creating an array of `FeedImage`:

![Feed API Diagram](diagram.png)

2) Follow the backend contract below:

### Remote Feed Image Spec

| Property      | Type                |
|---------------|---------------------|
| `image_id`    | `UUID`              |
| `image_desc`  | `String` (optional) |
| `image_loc`   | `String` (optional) |
| `image_url`	| `URL`               |

### Payload contract

```
200 RESPONSE

{
	"items": [
		{
			"image_id": "a UUID",
			"image_desc": "a description",
			"image_loc": "a location",
			"image_url": "https://a-image.url",
		},
		{
			"image_id": "another UUID",
			"image_desc": "another description",
			"image_url": "https://another-image.url"
		},
		{
			"image_id": "even another UUID",
			"image_loc": "even another location",
			"image_url": "https://even-another-image.url"
		},
		{
			"image_id": "yet another UUID",
			"image_url": "https://yet-another-image.url"
		}
		...
	]
}
```


## Instructions

The goal of this exercise is to get you used to the TDD flow.

We've provided you with appropriate tests to guide and validate your solution. You need to make all the tests pass, one by one, by implementing the `load` method in the existing `RemoteFeedLoader` class.

1) Fork the latest version of the challenge repo. Here's <a href="https://guides.github.com/activities/forking" target="_blank">how forking works</a>.

2) Open the `FeedAPIChallenge.xcodeproj` project on Xcode 14.2.

	- Other Xcode versions are not supported in this branch.
	
		- Challenges submitted with branches other than `xcode14_2` will be rejected.

3) There are two main folders in the project:
	- The `FeedAPIChallenge` folder contains the production types, including the `RemoteFeedLoader` and dependencies for requesting and loading the feed remotely. 

		- ⚠️ Important: ***You can create new files, but you should only change the `RemoteFeedLoader.swift` file to implement the `load` method.***

		- Do not change any other files in the folder.
	
	- The `Tests` folder contains the test cases. 

		- ⚠️ Important: ***You should only change the `LoadFeedFromRemoteUseCaseTests.swift` file to implement all test cases.***

		- Do not change any other files in the test folder.

	- Do not change any project settings, including scheme settings.

	- Do not change the indentation in the project.

	- Do not rename the existing classes and files.

	- Important: Every time you build the project, it'll automatically reformat the modified files with SwiftFormat to maintain the code consistent.

4) Use the `Tests/LoadFeedFromRemoteUseCaseTests.swift` to validate your implementation. 

	- Uncomment (CMD+/) and implement one test at a time following the TDD process: 
		- Make the test pass, commit, and move to the next one.

	- While developing your solutions, run all tests with CMD+U. 

5) Errors should be handled accordingly.
	- There shouldn't be *any* force-unwrap `!` or `fatalError` in production code.

	- There shouldn't be empty `catch` blocks.

	- There shouldn't be any `print` statements, such as `print(error)`.

6) The `FeedImage` should *not* implement `Decodable` - even in extensions. 

	- That's because the `CodingKeys` to decode the JSON are API-specific details defined in the backend. So declaring the `CodingKeys` in the `FeedImage` will couple it with API implementation details. And since other modules depend on the `FeedImage`, they'll also be coupled with API implementation details.

	- Suggestion: Create an API-specific struct in the 'Feed API' module to perform the decoding. Thus, preventing API details from leaking into other modules. So, for example, if there's a change in the backend, it doesn't propagate everywhere in the codebase. You just update the Feed API module without affecting others.

7) Make careful and proper use of access control (e.g., marking as `private` any implementation details that aren’t referenced from other external components).

8) When all tests are passing and you're done implementing your solution:

	- Review your code and make sure it follows **all** the instructions above.

		- If it doesn't, make the appropriate changes, push, and review your code again.

	- If it does, create a Pull Request from your branch to the main challenge repo's matching branch.

		- For example, if you implemented the challenge using the `xcode14_2` branch, your PR should be from your fork's `xcode14_2` branch into the main repo's `xcode14_2` branch (DO NOT MIX Xcode versions or you'll have merge conflicts!).

	- The title of the Pull Request should be: Your Name - Feed API Challenge
	
	- **Create only one Pull Request** and **do not close it**. If you have any issues, send a comment inside the Pull Request asking for help.

9) As soon as you create a Pull Request, we automatically receive a notification. You just need to create it and wait while we review your Pull Request and approve it or request any changes required with detailed feedback.

10) If instructors request changes in your Pull Request, **only push your changes once you're done with all changes** to avoid running CI for every tiny commit. 

	- CI server time isn't free. It's good practice to avoid running it on every tiny commit - so only push changes once you're done.

	- Abusing CI server time can lead to your GitHub account getting blocked.


## Guidelines

1) Aim to commit your changes every time you add/alter the behavior of your system or refactor your code.

2) Aim for descriptive commit messages that clarify the intent of your contribution which will help other developers understand your train of thought and purpose of changes.

3) The system should always be in a green state, meaning that in each commit all tests should be passing.

4) The project should build without warnings.

5) The code should be carefully organized and easy to read (e.g. indentation must be consistent).

6) Aim to write self-documenting code by providing context and detail when naming your components, avoiding explanations in comments.

Happy coding!
