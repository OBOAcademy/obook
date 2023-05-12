# How to review a pull request

## Overarching workflow

1. **Understand the Context**: First, read the description of the pull request (PR). It should explain what changes have been made and why. Understand the linked issue or task related to this PR. This will help you understand the context of the changes.

1. **Check the Size**: A good PR should not be too large, as this makes it difficult to understand the full impact of the changes. If the PR is very large, it may be a good idea to ask the author to split it into smaller, more manageable PRs.

1. **Review the Code**: Go through the code changes line by line. Check the code for clarity, performance, and maintainability. Make sure the code follows the style guide and best practices of your project. Look out for any potential issues such as bugs, security vulnerabilities, or performance bottlenecks.

1. **Check the Tests**: The PR should include tests that cover the new functionality or changes. Make sure the tests are meaningful, and they pass. If the project has a continuous integration (CI) system, all tests should pass in the CI environment.

1. **Manual Testing**: Depending on the change, it may be a good idea to check out the PR branch and test the changes manually. This can help catch issues that are not covered by automated tests.

1. **Check the Documentation**: If the PR introduces new functionality, it should also update the documentation accordingly. Even for smaller changes, make sure that comments in the code are updated.

1. **Give Feedback**: Provide constructive feedback on the changes. If you suggest changes, explain why you think they are necessary. Be clear, respectful, and concise. Remember, your goal is to help improve the quality of the code.

1. **Follow Up**: After you have provided feedback, check back to see if the author of the PR has made the suggested changes. You might need to have a discussion or explain your points further.

1. **Approve/Request Changes**: If you are satisfied with the changes and all your comments have been addressed, approve the PR. If not, request changes and explain what should be done before the PR can be approved.

1. **Merge the PR**: Once the PR is approved and all CI checks pass, it can be merged into the main branch. If your project uses a specific merge strategy (like squash and merge or rebase and merge), make sure it's followed.

## How to review the code / ontology changes properly

1. **Understand the Context**: Begin by familiarizing yourself with the purpose of the changes. Read the description of the pull request, any linked issues or tasks, and understand the feature or bug that the pull request is addressing.
1. **Review the Code Structure**: Look at the overall structure of the code. Check if the code is organized logically and consistently, follows the project's coding conventions, and whether the changes are made in the right place.
    * For Software, really think about stuff like wether the code is in an approporiate location (files, modules). If there are no specific coding standards, suggest to create one.
    * For ontologies, the key is that the change is to the right file (edit file, DOSDP patterns, ROBOT templates etc).  
1. **Check the Code Quality**: Review the code in detail. Look for any programming errors, potential performance issues, or security vulnerabilities. The code should be clean, efficient, and easy to understand. Pay attention to the naming conventions, error handling, edge cases, and potential bugs.
    * This is where you should spend most your time:
1. **Review the Tests**: Ensure the pull request includes tests and that they cover all important aspects of the new code. Check if all tests pass, and if the project has a continuous integration (CI) system, ensure all CI checks pass as well.
    * For ontologies, it is essential that a fix of a bug is augmented by a test that can recognise the same bug happening again in the future!
    * For code, it is a bit of a judgment call of whether a test is needed, but in general, we have to have at least _thorough integration tests_ that touch the feature affected by the pull request.
1. **Provide Constructive Feedback**: Provide clear, respectful, and constructive feedback. Highlight the parts of the code that you think are good and the parts that need improvement. Request changes if necessary, and approve the pull request once you're satisfied with the changes.

## How to review a pull request in 5 min

In many cases, we may not have the time to perform a proper code review. In this case, try at least to achieve this:

1. **Quick Contextual Understanding**: Glance through the pull request description and associated issues or tickets to grasp the context of the changes. The goal is not deep understanding, but a basic awareness of the purpose of the changes.
1. **File and Structure Overview**: Scan through the files and directories that have been modified. Note the overall structure of the changes, and look for any unusual modifications (e.g., changes in areas not related to the stated purpose of the pull request, large diffs that are not explained by the PR description).
1. **Random Code Sampling**: Instead of trying to read every line, pick a few sections of code at random to review. Pay attention to the cleanliness of the code, and see if there are any glaring issues or departures from the project's coding conventions.
1. **Check Automated Tests and Results**: Review the tests that have been added or modified. Check the results of the tests and automated build processes, if available. Even in a quick review, the status of the tests can provide useful information about the quality of the changes.
1. **Provide High-Level Feedback**: Based on your quick review, provide high-level feedback. This could include praising good practices you've noticed, pointing out major concerns or areas that seem off, or simply acknowledging the work with a comment.
