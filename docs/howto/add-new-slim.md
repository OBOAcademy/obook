**NOTE** This documentation is incomplete, for now you may be better consulting the [GO Editor Docs](http://wiki.geneontology.org/index.php/Ontology_Editing_Guide)

### Adding a new Subset (Slim)

See [Daily Workflow](daily-curator-workflow.md) for creating branches and basic Protégé instructions. 

1.	In the main Protege window, click on the Annotation Properties tab.

2.	Navigate to the ```subset_property``` and select it.

3.	Click on the top left-hand button of the window to add a new subset property.

4.	In the pop-up window add the name of the new slim. The identifier will fill in according to your preferences and will be the next identifier in your set. Click on Refactor in the menu. Select rename entities.

5.	Replace the ```IDSPACE_ identifier``` with the name of your new slim. It is standard to use the same string as when you created the term.

6.	In the annotations tab, click on the ```+```. 

7.	In the pop up window, select ```rdfs:comment```.

8.	In the right hand window, type a small descriptor statement for the slim. Select ```xsd:string``` as the type.

9.	Click OK to save the changes. You should now see the comment field in the annotations tab.

See [Daily Curator Workflow](daily-curator-workflow.md) section for commit, push and merge instructions. 

### Adding a term to a Subset (Slim)

See [Daily Curator Workflow](daily-curator-workflow.md) for creating branches and basic Protégé instructions. 

1. In Protege, navigate to the term you wish to add to a subset (slim).

2.	With the term selected, click on the Entities tab.

3.	In the Annotation window on the right, click on the ```+``` to the right of 'Annotations' at the very top of the window.

4.	In the pop-up window that appears, click on ```in_subset``` on the left-hand panel. 

5.	In the right-hand panel click on the ‘Entity IRI’ tab. 

6. Navigate to the 'Annotation Properties' sub-tab.

7.	Navigate to the subtypes of ```subset_property``` and select the appropriate slim.

8.	Click on OK to save your edits.
