# Setting up your ID Ranges

## Setting ID ranges in your ontology

1. Curators and projects are assigned specific ID ranges within the prefix for your ontology. See the README-editors.md for your ontology

2. An example: [uberon-idranges.owl](https://github.com/obophenotype/uberon/blob/master/src/ontology/uberon-idranges.owl)

3. **NOTE:** You should only use IDs within your range.

4. If you have only just set up this repository, modify the idranges file and add yourself or other editors.

## Setting ID ranges

### Protege 5.6

Protégé 5.6 can now automatically set up the ID range for a given user by exploiting the `ONT-idranges.owl` file, if it exists. ONT is the name of the ontology you are editing (for example, in UBERON, the file is named `uberon-idranges.owl`).  The file is automatically created by the ODK, so that users shouldn’t need worry about it.

This Protege version looks at the ID range file and matches your user name in Protege to the names in the file to automatically set up your ID range. Thus as long as this information matches you no longer need to manually set the ID range. You will get a message if your user name does not match one in the file asking you to pick an ID range.

**Note**: If you are switching from an old Protege version to Protege 5.6, you may need to reset your range to the last used ID rather than just the full range or Protege would try to fill in gaps in the range.

### Protege 5.5.0 or below

ID ranges need to be manually set in Protege 5.6.0 or below, as described below.

#### Setting ID ranges in Protege in Protege 5.5.0 or below

1. Once you have your assigned ID range, you need to configure Protege so that your ID range is recorded in the Preferences menu. Protege does not read the idranges file.

2. In the Protege menu, select Preferences.

3. In the resulting pop-up window, click on the New Entities tab and set the values as follows.

4. In the Entity IRI box:

   **Start with:** Specified IRI: [http://purl.obolibrary.org/obo](http://purl.obolibrary.org/obo)

   **Followed by:** `/`

   **End with:** `Auto-generated ID`

5. In the Entity Label section:

   **Same as label renderer:** IRI: [http://www.w3.org/2000/01/rdf-schema#label](http://www.w3.org/2000/01/rdf-schema#label)

6. In the Auto-generated ID section:

   - Numeric

   - Prefix `GO_`

   - Suffix: _leave this blank_

   - Digit Count `7`

   - **Start:** see [go-idranges.owl](https://github.com/geneontology/go-ontology/blob/master/src/ontology/go-idranges.owl). Only paste the number after the `GO:` prefix. Also, note that when you paste in your GO ID range, the number will automatically be converted to a standard number, e.g. pasting 0110001 will be converted to 110,001.)

   - **End:** see [go-idranges.owl](https://github.com/geneontology/go-ontology/blob/master/src/ontology/go-idranges.owl)

   - Remember last ID between Protege sessions: ALWAYS CHECK THIS

   (**Note:** You want the ID to be remembered to prevent clashes when working in parallel on branches.)
