# Editing a term in protege

Before you start:

- make sure you are working on a branch [here](https://docs.google.com/presentation/d/1M8NZQOIQVswng-so6ROxVeMJfDnzth7BYNj_5MXxEik/edit#slide=id.g9db6baf776_1_0).
- make sure you have the editor's file open in Protege (in ODK ontologies, located in: ./src/ontology/ONT-edit.owl) where ONT is the name of your ontology (eg mondo-edit.owl for MONDO)
- familiarise yourself with the user [interface of protege](../reference/protege-interface.md)

## Adding, editing, annotating and deleting axioms

#### Adding annotations 

Using Protégé you can add annotations such as labels, definitions, synonyms, database cross references (dbxrefs) to any OWL entity. The panel on the right, named Annotations, is where these annotations are added. OBO Foundry ontologies includes a pre-declared set of annotation properties. The most commonly used annotations are below.

- rdfs:label
- definition
- has_exact_synonym
- has_broad_synonym
- has_narrow_synonym
- has_related synonym
- database_cross_reference
- rdfs:comment

Note: OBO ontologies allow only one rdfs:label, definition, and comment.

Note, most of these are bold in the annotation property list:

![](https://lh5.googleusercontent.com/NL1uWNo9KSETrkPBCCG92Tw6CSsE0oW7qIPZWK6NJ7PJx6YdGE4YxaFEZgN5OfMf8VzTVNmL2whgIv2FvSkYc0ASHM4YfN0l8psVcgjT-5SG2uEDncBUMoCozhP1vjqRyYPnIprS)

Use this panel to add a definition to the class you created. Select the + button to add an annotation to the selected entity. Click on the annotation 'definition' on the left and copy and paste in the definition to the white editing box on the right. Click OK.

Example (based on MONDO):

Definition: A disorder characterized by episodes of swelling under the skin (angioedema) and an elevated number of the white blood cells known as eosinophils (eosinophilia). During these episodes, symptoms of hives (urticaria), fever, swelling, weight gain and eosinophilia may occur. Symptoms usually appear every 3-4 weeks and resolve on their own within several days. Other cells may be elevated during the episodes, such as neutrophils and lymphocytes. Although the syndrome is often considered a subtype of the idiopathic hypereosinophilic syndromes, it does not typically have organ involvement or lead to other health concerns.

![](https://lh3.googleusercontent.com/4p6jqLqln6U1NHs71h30sdbqfPjSop7KxLJrF_JFfapYPPnBL1A3uA4MHRhqXHUA5YLN7rezy7SD1vNH-KslUWM5qb_Z8PP9IWQJSfg2GzX5XL3aa1CkcAtiR46tETCnwzIXHukm)

![](https://lh4.googleusercontent.com/TP0O04TD6kN1rEn1EM1GcXoWJGz-EsFNihzHSOQi-Q4tq65f1Qpd66ItPFVqn6SuQhDge5PSbiXGz2XwoykEYKxe6f3wwCN0j70bNv3WArJE_wOZSjeMNokuLVEx0r9Odbh0rG9L)

Definitions in OBO ontologies should have a 'database cross reference' (dbxref), which is a reference to the definition source, such as a paper from the primary literature or another database. For references to papers, we cross reference the PubMed Identifier in the format, PMID:XXXXXXXX. (Note, no space)

To add a dbxref to the definition:

1.  Click the @ symbol next to the definition
1.  Click the + button next in the pop-up window
1.  Scroll up on the left hand side until you find 'database_cross_reference', and click it
1.  Add the PMID in the editing box (PMID:25527564). \_Note: the PMID should not have any spaces)
1.  Click OK
1.  Add the additional dbxref (e.g., adding GARD:0013029)
1.  The dbxrefs should appear as below.

![](https://lh6.googleusercontent.com/l589uvv3OKKxrabrqKQdL-NF6PfKi_mSfaz-xk--59WtSD15VOy9CQVZXdE0SHl6ZA761zv9G0UULHF5EKRfMToX2F0kqrwuGbjdnzVV3JRRJbb2l40UjOLeXi-7aM_TBkCSkN3L)

![](https://lh6.googleusercontent.com/aW3quN013aSDfyFXpn-_prKrn0TN7eMzodwK4HdryZ_Zbjade5xZWnFCVt8flkRqIbMy5eT5lKzFEimuGNgJ3YYYybI5rgdcmVWUzzfdwFeXjJSFBpNjqgv27kZVPiazcMiZABn1)

#### Add Synonyms and Database cross reference

To add a synonym:

1.  Select the + button to add an annotation to the selected entity
1.  Add the synonyms as 'has_exact_synonym' (note: use [appropriate synonym annotation](../reference/synonyms-obo.md))
1.  Synonyms should have a reference to it
1.  Click the @ symbol next to the synonym
1.  Click the + button
1.  Select `database_cross_reference` on the left panel and add your reference to the Literal tab on the right hand side

<a name="class-description"></a>

### The Class description view

We have seen how to add sub/superclasses and annotate the class hierarchy. Another way to do the same thing is via the Class description view. When an OWL class is selected in the entities view, the right-hand side of the tab shows the class description panel. If we select the 'vertebral column disease' class, we see in the class description view that this class is a "SubClass Of" (= has a SuperClass) the 'musculoskeletal system disease' class. Using the (+) button beside "SubClass Of" we could add another superclass to the 'skeletal system disease' class.

Note the Anonymous Ancestors. These are superclasses that are inherited from the parents. If you hover over the Subclass Of (Anonymous Ancestor) you can see the parent that the class inherited the superclass from.

![](https://lh4.googleusercontent.com/hC3R3tw3S5eVNLc70iCN0lrtj9rD_gIPUBxberpw4gSRRR6xct1Xv5dHYSfXPchpYvpGMhIgGnQQ18dl6pWicyClpL-GGyi_JjkeSKOetm4hleSfA-kxu6ww6v-3q-NOLj3xhd7m)

When you press the '+' button to add a `SubClass of` axiom, you will notice a few ways you can add a term. The easiest of this is to use the Class expression editor. This allows you to type in the expression utilizing autocomplete. As you start typing, you can press the 'TAB' or '->|' button on your keyboard, and protege will suggest terms. You will also note that the term you enter is not in the ontology, protege will not allow you add it, with the box being highlighted red, and the term underlined red.

### Make a Pull Request

1.  Make a pull request as usual ([instructions here](../howto/github-create-pull-request.md))
