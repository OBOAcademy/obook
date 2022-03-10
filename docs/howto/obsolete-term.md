# Obsoleting an Existing Ontology Term

See [Daily Workflow](daily-curator-workflow.md) for creating branches and basic Protégé instructions.

Warning: Every ontology has their procedures on how they obsolete terms (eg notice periods, notification emails, to_be_obsolete tags, etc.), this how-to guide only serves as a guide on how obsolete a term directly on protege. 

### PRE OBSOLETION PROCESS (or basic obsoletion etiquette)
1. Check if the term (or any of its children) is being used for annotation: 
   - Go to your ontology browser of choice, search for the term, either by label or ID
   - See which other ontologies use the to be obsolete term
   - Notify affected groups (usually by adding an issue in their tracker)

2. Check if the term is used elsewhere in the ontology
   - In Protégé, navigate to the term to be obsolete and go to the 'Usage' tab to see if that ID is used elsewhere.
   - If the term is a parent to other terms or is used in logical definitions, make sure that another term replaces the obsolete term

### OBSOLETION PROCESS 

Warning: some ontologies give advance notice on terms that will be obsoleted through the annotation 'scheduled for obsoletion on or after' instead of directly obsoleting the term. Please check with the conventions of your ontology before obsoleting a term. 

1. Navigate to the term to be obsoleted.

![](../images/howtoguides/obsolete/fig1.png)

2. Select Edit > Deprecate entity...

![](../images/howtoguides/obsolete/fig2.png)

3. A deprecation wizard will pop up, in here, select GO style, and select continue (note this is specifc to GO style ontologies, if you are working with an OBI style ontology, there is an option for that too, if not use basic. For this how to, we will follow GO style)

![](../images/howtoguides/obsolete/fig3.png)

4. Next, enter your reason for deprecation. For this, we advice for you to enter the github issue. (eg https://github.com/obophenotype/cell-ontology/issues/####) This will appear as a rdfs:comment

![](../images/howtoguides/obsolete/fig4.png)

5. Next enter a replacement entity if there is one. This will automatically replace axioms in the ontology with the term, and add an 'item replaced by' axiom on the obsolete term.

![](../images/howtoguides/obsolete/fig5.png)

6. Your obsolete term should now be stripped of its logical axioms and should look like the figure below. 

![](../images/howtoguides/obsolete/fig6.png)

7. Add any additional axioms needed - this is specific to ontologies and you should consult the conventions of the ontology you are working on. 

Examples of additional axioms to add: 
- rdfs:seeAlso - link to github issue
- has_obsolence_reason 

See [Daily Workflow](daily-curator-workflow.md) section for commit, push and merge instructions. 
