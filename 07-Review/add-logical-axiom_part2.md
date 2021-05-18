## Add a New Term with an Equivalance Axiom to Mondo: 

### Add the new term 'cork workers lung'

1. Create a new branch (named cork-workers-lung) and open mondo-edit.obo in Protege.
1. Search for the parent term 'extrinsic allergic alveolitis'
1. When you are clicked on the term in the Class hierarchy pane, click the add subclass button to add a child class to 'extrinsic allergic alveolitis'
1. A dialog will popup. Name this new subclass: cork workers lung. Click "OK" to add the class.

#### Add annotations and a logical axiom 

For this class, we want to follow the design pattern for [specific_infectious_disease_by_agent](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/specific_infectious_disease_by_agent.yaml) with a slight modification, this will be modeled after ''.

1. Add a text definition to this term: 'An extrinsic allergic alveolitis caused by infection with Penicillium glabrum.'.
1. Add the database cross reference to this term: MONDO:patterns/specific_infectious_disease_by_agent
1. Add a synonym that is consistent with this pattern.

1. Add the equivalence axiom according to the pattern specifications.

`'extrinsic allergic alveolitis'
 and 'infectious disease'
 and ('disease has infectious agent' some Penicillium glabrum)`

1. Run the reasoner
1. View the inferred hierarchy.
1. Confirm that there are no unsatisifiable classes and everything looks okay.
1. Save your work and create a pull request and reference issue #1639.





