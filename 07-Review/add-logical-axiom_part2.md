## Add a New Term with an Equivalance Axiom to Mondo: 

### Add annotations and logical definition (equivalence axiom) to MONDO:0004549 'cork-handlers' disease'

1. Create a new branch (named cork-handler) and open mondo-edit.obo in Protege.
1. Search for the term `cork-handlers' disease`

For this class, we want to follow the design pattern for [specific_infectious_disease_by_agent](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/specific_infectious_disease_by_agent.yaml) with a slight modification, this will be modeled after `MONDO:0002266 'malt worker's lung'`.

1. Add the synonym: `cork worker's lung`
1. Add the equivalence axiom according to the pattern specifications.

`'extrinsic allergic alveolitis'
 and 'infectious disease'
 and ('disease has infectious agent' some Penicillium glabrum)`

1. Run the reasoner
1. View the inferred hierarchy.
1. Confirm that there are no unsatisifiable classes and everything looks okay.
1. Save your work and create a pull request and reference issue #1639.

### Add annotations and logical definition (equivalence axiom) to 

1. Create a new branch (named farmer-lung) and open mondo-edit.obo in Protege.
1. Search for the term `'farmer's lung disease'`
1. Similar to above, we want to add a logical axiom. In this case though, Farmer's lung can be caused by more than one infectious agent, so we'll add this as a subclassOf axiom:
`'disease has infectious agent' some Penicillium glabrum`

1. Run the reasoner
1. View the inferred hierarchy.
1. Confirm that there are no unsatisifiable classes and everything looks okay.
1. Save your work and create a pull request and reference issue #1639.


