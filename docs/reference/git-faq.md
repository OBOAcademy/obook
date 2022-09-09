# Git FAQs

This page aims to consolidate some tips and tricks that ontology editors have found useful in using `git`. It is not meant to be a tutorial of `git`, but rather as a page with tips that could help in certain specialised situations.

## Reverting Commits

### Reverting particular files back to master version

1. If you want to revert only certain files (eg import files), you can do it using Terminal. For this example, we will use uberon_import.owl as the file we want reverted back to the version in master branch, however, this can be done on any file.
2. Assuming your directory is set to `src/ontology`, in terminal use: `git checkout master -- imports/uberon_import.owl`.
3. Commit the change to the branch as normal.

### Reverting particular files back to a previous version

1. If you want to revert a file back to a previous version instead of master, you can use the commit ID.
2. To do this, in Terminal use: `git log` to list out the previous commits and copy the commit code of the commit you would like to revert to (example: see yellow string of text in screenshot below).

![Screenshot 2021-10-15 at 13 34 06](https://user-images.githubusercontent.com/76212760/137487473-987c9a4a-6e17-45fe-8a21-e029443784c4.png)

3. Press q on your keyboard to quit git log (or down arrow to scroll down to continue to find the commit ID you want to revert if it is further down).
4. In terminal use: `git checkout ff18c9482035062bbbbb27aaeb50e658298fb635 -- imports/uberon_import.owl` using whichever commit code you want instead of the commit code in this example.
5. commit the change to the branch as normal.
