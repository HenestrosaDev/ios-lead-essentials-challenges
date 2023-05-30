# The Feed Store Challenge - iOSLeadEssentials.com

![](https://github.com/essentialdevelopercom/ios-lead-essentials-feed-store-challenge/workflows/CI/badge.svg)

You are called to build a new infrastructure component that conforms to the `<FeedStore>` protocol using **Core Data** to persist the feed.

## Instructions

1) Fork the latest version of this repository. Here's <a href="https://guides.github.com/activities/forking" target="_blank">how forking works</a>.

2) Open the `FeedStoreChallenge.xcodeproj` project on Xcode 14.2.
	
	- Other Xcode versions are not supported in this branch.
	
		- Challenges submitted with branches other than `xcode14_2` will be rejected.

	- Do not change any project settings, including scheme settings.

	- Do not change the indentation in the project.

	- Do not rename the existing classes and files.

	- Important: Every time you build the project, it'll automatically reformat the modified files with SwiftFormat to maintain the code consistent.

3) Implement a `<FeedStore>` protocol implementation using **Core Data** in the `CoreDataFeedStore.swift` file.

	- There shouldn't be any extra logic in the `CoreDataFeedStore` implementation. 
		
		- It should just obey to the retrieve/insert/delete commands without any extra logic.
			
			- For example, *don't* check if the array of images is empty - and *don't* replace optional values with default values such as `Date()`.

			- This kind of logic shouldn't be in the infrastructure store implementation.

	- We already provided the Core Data boilerplate and the tests.

4) Use the `Tests/FeedStoreChallengeTests.swift` to validate your implementation conforms to the store specs.
	
	- Uncomment (CMD+/) and implement one test at a time following the TDD process: 
	
		- Make the test pass, commit, and move to the next one.

	- While developing your solutions, run all tests with CMD+U.

5) Use the `Tests/FeedStoreIntegrationTests.swift` to validate that your implementation persists data to disk correctly.

	- Uncomment and implement one integration test at a time following the TDD process: Make the test pass, commit, and move to the next one.

6) Errors should be handled accordingly.
	
	- There shouldn't be *any* force-unwrap `!` or `fatalError` in production code.

	- There shouldn't be empty `catch` blocks.

	- There shouldn't be any `print` statements, such as `print(error)`.

7) When all tests are passing and you're done implementing your solution:

	- Review your code and make sure it follows **all** the instructions above.

		- If it doesn't, make the appropriate changes, push, and review your code again.

	- If it does, create a Pull Request from your branch to the main challenge repo's matching branch.

		- For example, if you implemented the challenge using the `xcode14_2` branch, your PR should be from your fork's `xcode14_2` branch into the main repo's `xcode14_2` branch (DO NOT MIX Xcode versions or you'll have merge conflicts!).

	- The title of the Pull Request should be: Your Name - Feed Store Challenge

	- **Create only one Pull Request** and **do not close it**. If you have any issues, send a comment inside the Pull Request asking for help.

8) As soon as you create a Pull Request, we automatically receive a notification. You just need to create it and wait while we review your Pull Request and approve it or request any changes required with detailed feedback.

9) If instructors request changes in your Pull Request, **only push your changes once you're done with all changes** to avoid running CI for every tiny commit. 

	- CI server time isn't free. It's good practice to avoid running it on every tiny commit - so only push changes once you're done.

	- Abusing CI server time can lead to your GitHub account getting blocked.


## Guidelines

1) Aim to commit your changes every time you add/alter the behavior of your system or refactor your code.

2) Aim for descriptive commit messages that clarify the intent of your contribution which will help other developers understand your train of thought and purpose of changes.

3) The system should always be in a green state, meaning that in each commit all tests should be passing.

4) The project should build without warnings.

5) The code should be carefully organized and easy to read (e.g. indentation must be consistent).

6) Make careful and proper use of access control, marking as `private` any implementation details that aren’t referenced from other external components.

7) Aim to write self-documenting code by providing context and detail when naming your components, avoiding explanations in comments.

8) Aim to declare dependencies explicitly, leveraging dependency injection wherever necessary.

9) Aim **not** to block the main thread - run expensive operations in a background queue.

Happy coding!
