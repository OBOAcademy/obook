# Protegé FAQs

## How to escape characters in the class expression editor

To add an ontology term (such as a GO term) that contains `'` in its name (e.g. `RNA-directed 5'-3' RNA polymerase activity`) in the class expression editor, you need to escape the `'` characters. In Protegé 5.5 this is not automatically handled when you auto-complete with tab. To escape the character append `\` before the `'` -> `RNA-directed 5\'-3\' RNA polymerase activity`. You won't be able to add the annotation otherwise.

As in Protegé 5.5, the `\` characters will show up in the description window, and when hovering over the term, you won't be able to click on it with a link. However, when you save the file, the relationship is saved correctly. You can double-check by going to the ontology text file and see that the term is correctly mentioned in the relationship.
