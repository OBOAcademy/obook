# How to change files in an existing pull request

## Using GitHub

Warning: You should only use this method if the files you are editing are reasonably small (less than 1 MB).

This method only works if the file you want to edit has already been editing as part of the pull request.

- Go to the pull request on GitHub, and click on the "Files Changed" tab up top
- Find the file you want to edit in the pull request.
- On the right, click on on the three `...`, and then "Edit file".

![changepr](../images/changing_pr.png)

If this option is greyed out, it means that - you don't have edit rights on the repository - the edit was made from a different fork, and the person that created the pull request did not activate the "Allow maintainers to make edits" option when submitting the PR - the pull request has already been merged

- Do the edits, and then commit changes, usually to the same branch
  ![changepr](../images/changing_pr_commit.png)

## Using GitHub Desktop

1. On the pull request in GitHub, click the copy button next to the branch name (see example below)

<img width="194" alt="image" src="https://user-images.githubusercontent.com/6722114/219119000-8f87c085-581d-4f4d-98af-696575d9f0a5.png">

2. In GitHub Desktop, click the branch switcher button and paste in branch name (or you can type it in).
<img width="425" alt="image" src="https://user-images.githubusercontent.com/6722114/219119093-2091cdda-8ee4-44cf-aa7a-5654f821e2bd.png">

3. Now you are on the branch, you can open the files to be edited and make your intended changes and push via the usual workflow.

### If the branch is on a fork

1. If a user forked the repository and created a branch, you can find that branch by going to the branch switcher button in GitHub Desktop, click on Pull Requests (next to Branches) and looking for that pull request
<img width="387" alt="image" src="https://user-images.githubusercontent.com/6722114/219119160-909a1bc9-950c-46d4-9b53-781551b686ac.png">

2. Select that pull request and edit the appropriate files as needed and push via the usual workflow.
