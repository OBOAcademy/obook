# Fixing merge conflicts

This [video](https://drive.google.com/file/d/1DqYiXEdkLCVji55FmFlA9sPmfLouEqrj/view?usp=sharing) illustrates an example of fixing a merge conflict in the mondo ontology.



**Instructions:**

1. If a merge conflict error appears in your Github.com pull request after commiting a change, open GitHub Desktop and select the corresponding repository from the "Current Repository" button.

2. With the repository selected, click the "Fetch origin" button to fetch the most up-to-date version of the repository.
3. Click the "Current Branch" button and select the branch with the merge conflict.

4. From the menu bar, select Branch > "Update from master".

5. A message indicating the file with a conflict should appear along with the option to open the file (owl or obo file) in a text/code editor, such as Sublime Text. Click the button to open the file. 

6. Search the file for conflict markings ( <<<<<<< ======= >>>>>>> ).

7. Make edits to resolve the conflict, e.g., arrange terms in the correct order.

8. Remove the conflict markings.

9. Save the file.

10. Open the file in Protégé. If prompted, do not reload any previously opened file. Open as a new file.

11. Check that the terms involved in the conflict appear OK, i.e., have no obvious errors.

12. Save the file in Protégé using File > 'Save as...' from the menu bar and replace the ontology edit file, e.g., mondo-edit.obo

13. Return to GitHub Desktop and confirm the conflicts are now resolved. Click the "Continue Merge" button and then the "Push origin" button.

14. Return to Github.com and allow the QC queries to rerun.

15. The conflict should be resolved and the branch allowed to be merged.
