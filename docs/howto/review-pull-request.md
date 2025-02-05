# How to review a pull request

Pull Requests are GitHub's mechanism for allowing one person to propose changes to a file (which could be a chunk of code, documentation, or an ontology) and enabling others to comment on (review) the proposed changes. You can learn more about creating Pull Requests (PRs) [here](../howto/github-create-pull-request.md); this document is about reviewing other people's PRs.

One key aspect of reviewing pull requests (aka code review or ontology change review) is that the purpose is not just to improve the quality of
the proposed change. It is also about _building shared coding habits and practices_ and improving those practices for all engineers (ontology and software) across a whole organisation (effectively building the breadth of project knowledge of the developers and reducing the amount of hard-to-understand code). 

Reviewing is an important aspect of open science and engineering culture that needs to be learned and developed. In the long term, this habit will have an effect on the growth and impact of our tools and ontologies comparable to the engineering itself.

It is _central_ to open science work that we review other people's work _outside our immediate team_. We recommend choosing a few people with whom to mutually review your work, whether you develpo ontologies, code or both. It is of great importance that **pull requests are addressed in a timely manner**, ideally within 24 hours of the request. The requestor is likely in the headspace of being receptive to changes and working hard to get the code fixed when they ask for a code review.

## Overarching workflow

1. **Understand the Context**: First, read the description of the pull request (PR). It should explain what changes have been made and why. Understand the linked issue or task related to this PR. This will help you understand the context of the changes.

1. **Check the Size**: A good PR should not be too large, as this makes it difficult to understand the full impact of the changes. If the PR is very large, it may be a good idea to ask the author to split it into smaller, more manageable PRs.

1. **Review the Code**: Go through the code changes line by line. Check the code for clarity, performance, and maintainability. Make sure the code follows the style guide and best practices of your project. Look out for any potential issues such as bugs, security vulnerabilities, or performance bottlenecks.

1. **Check the Tests**: The PR should include tests that cover the new functionality or changes. Make sure the tests are meaningful, and they pass. If the project has a continuous integration (CI) system, all tests should pass in the CI environment. In some cases, manual testing may be helpful (see below).

1. **Check the Documentation**: If the PR introduces new functionality, it should also update the documentation accordingly. Even for smaller changes, make sure that comments in the code are updated.

1. **Give Feedback**: Provide **constructive** feedback on the changes. If you suggest changes, explain why you think they are necessary. Be clear, respectful, and concise. Remember, your goal is to help improve the quality of the code.

1. **Follow Up**: After you have provided feedback, check back to see if the author of the PR has made the suggested changes. You might need to have a discussion or explain your points further.

1. **Approve/Request Changes**: If you are satisfied with the changes and all your comments have been addressed, approve the PR. If not, request changes and explain what should be done before the PR can be approved.

1. **Merge the PR**: Once the PR is approved and all CI checks pass, it can be merged into the main branch. If your project uses a specific merge strategy (like squash and merge or rebase and merge), make sure it's followed.

## How to review the code / ontology changes thoroughly

1. **Ensure that the PR links to a related issue that explains the context of the PR**. If there is no issue, request that an issue be created to motivate the change in the PR (gently - accept if the answer is negative).
1. **Understand the Context**: Begin by familiarizing yourself with the purpose of the changes. Read the description of the pull request, any linked issues or tasks, and understand the feature or bug that the pull request is addressing.
1. **Ensure that all changes in the PR are intentional**. Changes should be small. If there are a lot of unrelated changes, in particular line ending changes, serialisation changes in ontology (e.g. a lot of added `xsd:string` declarations), request before doing a review to reduce the changes to only the changes pertaining to the specific issue at hand.
1. **Review the Code Structure**: Look at the overall structure of the code. Check if the code is organized logically and consistently, follows the project's coding conventions, and the changes are made in the right place.
    * For software, consider factors like whether the code is in an approporiate location (files, modules). If there are no specific coding standards for the project, suggest that such standards be created.
    * For ontologies, check that the change is to the right file (edit file, DOSDP patterns, ROBOT templates etc.).  
1. **Check the Code Quality**: Review the code in detail. Look for any programming errors, potential performance issues, or security vulnerabilities. The code should be clean, efficient, and easy to understand. Pay attention to the naming conventions, error handling, edge cases, and potential bugs.
    * The two items below are where you should spend most of your time:
1. **Review the Tests**: Ensure that the PR includes tests and that they cover all important aspects of the new code. Check if all tests pass, and if the project has a continuous integration (CI) system, ensure all CI checks pass as well.
    * For ontologies, it is essential that a bug fix is augmented by a test that can recognise the same bug happening again in the future!
    * For code, it is a bit of a judgment call whether a test is needed, but in general, we have to have at least _thorough integration tests_ that touch the feature affected by the pull request.
1. **Test the Changes Manually (use with care)**: Depending on the change, it may be a good idea to check out the PR branch and test the changes manually. This can help catch issues that are not covered by automated tests, or may be necessary if the diff is too large for a normal review. Note that this is an instance of [Guru Testing](https://wiki.c2.com/?GuruChecksOutput) and should only be used when there is a sense that automated testing is incomplete. If at all possible, an automated test should be run immediately after the manual review is done. Examples of where this kind of manual review may be appropriate are cases where, for example, a lot of the class hierarchy of an ontology is affected by a change. Manual review may catch issues such as missing superclasses which are hard to capture through automated testing.
1. **Provide Constructive Feedback**: Provide clear, respectful, and constructive feedback. Highlight the parts of the code that you think are good and the parts that need improvement. Request changes if necessary, and approve the PR once you're satisfied with the changes.

## How to review a pull request in 5 min

In many cases, we may not have the time to perform a proper code review. In that case, try at least to achieve this:

1. **Ensure that the PR has a related issue that explains the context of the PR** (see above).
1. **Ensure that all changes in the PR are intentional** (see above).
1. **File and structure overview**: Scan through the files and directories that have been modified. Note the overall structure of the changes, and look for any unusual modifications (e.g., changes in areas not related to the stated purpose of the PR, or large diffs that are not explained by the PR description).
1. **Random code sampling**: Instead of trying to read every line, pick a few sections of code at random to review. Pay attention to the cleanliness of the code, and see if there are any glaring issues or departures from the project's coding conventions.
1. **Check automated tests and results**: Review the tests that have been added or modified. Check the results of the tests and automated build processes, if available. Even in a quick review, the status of the tests can provide useful information about the quality of the changes.
1. **Provide high-level feedback**: Based on your quick review, provide high-level feedback. This could include praising good practices you've noticed, pointing out major concerns or areas that seem off, or simply acknowledging the work with a comment.

## Video explanations

### How to review an Obsoletion PR in Mondo

<iframe width="560" height="315" src="https://www.youtube.com/embed/h7NwC3LG8FI?si=55ktNL6U7V7OQX7_" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### How to review a merge PR in Mondo

<iframe width="560" height="315" src="https://www.youtube.com/embed/XElHQ6knEpw?si=84SnvIrpf17IOsD8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
