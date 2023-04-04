### Adding a new subset (also known as a "slim")

See [Daily Curator Workflow](daily-curator-workflow.md) for creating branches and basic Protégé instructions.

1. In the main Protégé window, click on the "Entities" tab. Below that, click the "Annotation properties" tab.

2. Select the `subset_property` annotation property.

3. Click on the "Add sub property" button.

4. In the pop-up window, add the name of the new slim. The IRI will automatically populate according to settings in the user's "New entities" settings. Click OK.

5. With the newly created annotation property selected, click on "Refactor > Rename entity..." in the menu.

6. In the pop-up window, select the "Show full IRI" checkbox. The IRI will appear. 
Edit the IRI to fit the following standard:

http://purl.obolibrary.org/obo/{ontology_abbreviation}#{label_of_subset}


For example, in CL, the original IRI will appear as:

http://purl.obolibrary.org/obo/CL_1234567

If the subset was labeled "kidney_slim", the IRI should be updated to:

http://purl.obolibrary.org/obo/cl#kidney_slim


7. In the 'Annotations" window, click the `+` next to "Annotations".

8. In the pop-up window, select the `rdfs:comment` annotation property. Under "Value" enter a brief descripton for the slim. Under "Datatype" select `xsd:string`. Click OK.


See [Daily Curator Workflow](daily-curator-workflow.md) section for commit, push and merge instructions.

### Adding a class (term) to a subset (slim)

See [Daily Curator Workflow](daily-curator-workflow.md) for creating branches and basic Protégé instructions.

1. In the main Protégé window, click on the "Entities" tab. Select the class that is to be added to a subset (slim).

2. In the 'Annotations" window, click the `+` next to "Annotations".

4. In the pop-up window, select the `in_subset` annotation property.

5. Click on the ‘Entity IRI’ tab.

6. Search for the slim label under "Entity IRI". In the pop-up that appears, double-click on the desired slim. Ensure that a sub property of `subset_property` is selected. Click OK.


See [Daily Curator Workflow](daily-curator-workflow.md) section for commit, push and merge instructions.