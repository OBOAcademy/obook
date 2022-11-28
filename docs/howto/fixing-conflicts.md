# Fixing merge conflicts

This [video](https://www.youtube.com/watch?v=cB1ZDfBNNN0) illustrates an example of fixing a merge conflict in the Mondo Disease Ontology.

**Instructions:**

1. If a merge conflict error appears in your Github.com pull request after committing a change, open GitHub Desktop and select the corresponding repository from the "Current Repository" button. If the conflict emerged after editing the ontology outside of Protégé 5.5.0, see _Ad hoc Reserialisation_ below.

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

**Ad hoc Reserialisation**

If the owl or obo file involved in the merge conflict was edited using Protégé 5.5.0, the above instructions should be sufficient. If edited in any other way, such as fixing a conflict in a text editor, the serialisation order may need to be fixed. This can be done as follows:

1. Reserialise the master file using the Ontology Development Kit (ODK). This requires setting up Docker and ODK. If not already set up, follow [the instructions here](https://oboacademy.github.io/obook/howto/odk-setup/).

2. Open Docker.

3. At the line command (PC) or Terminal (Mac), use the cd (change directory) command to navigate to the repository's src/ontology/ directory.
   For example,

`cd PATH_TO_ONTOLOGY/src/ontology/`

Replace "PATH_TO_ONTOLOGY" with the actual file path to the ontology. If you need to orient yourself, use the `pwd` (present working directory) or `ls` (list) line commands.

4. If you are resolving a conflict in an .owl file, run:

`sh run.sh make normalize_src`

If you are resolving a conflict in an .obo file, run:

`sh run.sh make normalize_obo_src`

5. In some ontologies (such as the Cell ontology (CL)), edits may result in creating a large amount of unintended differences involving ^^xsd:string. If you see these differences after running the command above, they can be resolved by following [the instructions here](https://obophenotype.github.io/cell-ontology/Fixing_xsdstring_diffs/).

6. Continue by going to step 1 under the main **Instructions** above.
