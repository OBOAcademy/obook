## Add New Terms to Mondo: 

### Setup

#### Setting Preferences for New entities

Ontology terms have separate names and IDs. The names are annotation values (labels) and the IDs are represented using IRIs. The OBO foundry has a policy on IRI (or ID) generation (<http://www.obofoundry.org/principles/fp-003-uris.html>). You can set an ID strategy using the "New Entities" tab under the Protégé Preferences -- on the top toolbar, click the "Protégé dropdown, then click Preferences.

![image](https://user-images.githubusercontent.com/6722114/115822913-3302d400-a3ba-11eb-89eb-70c767701843.png)

Set your new entity preferences precisely as in the following screenshot of the New Entities tab.  

**Note** -  you have been assigned an ID range in the Mondo [idranges file](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/mondo-idranges.owl)  - you should be able to find your own range assigned there.

![image](https://user-images.githubusercontent.com/6722114/115964257-6a67a280-a4d8-11eb-8dcd-768b51d75720.png)

Specified IRI: http://purl.obolibrary.org/obo/

Note - if you edit more than one ontology in Protege, you will need to update your Preferences for each ontology before you edit.

#### Setting Preferences for User details

User name: click Use supplied user name and enter your username in the field below

Click Use Git user name when available

In the ORCID field, add your ORCID ID (in the format 0000-0000-0000-0000)

![](https://lh5.googleusercontent.com/zSBnZv_ki8Y_5Kll4mNKCpTOoS030-UGVww8D5E3-TyDKUTnVvYaNsHIGezIsHWM3LQLah5R5SFwdgAY8wppqRcORtwdGQfuO3Y7Up9QT7TSPZU938rcz3UujRijm6ejwGwuFKNw)

#### Setting Preferences for New entities metadata

You can have Protege add a 'created by' annotation with your ORCID or GitHub username for every new term that you create.

Set your preferences to match the screenshot below, in the New entities metadata tab (under preferences).

If you do not have an ORCID, register for for free here: <https://orcid.org/> 

![](https://lh3.googleusercontent.com/L8OnTKLNmYsTLZn6fHVdONVFe_cA-OhRLr5iO-MHld_zePvnA0ECImFKDXoqOeP0vKSHKRE8-LQYoqz5lbk9st8paCbmA74UPMb1LHmrpMuXsXbY_ZmYAsN6L8zNRCfbBHPKvv5A)

### EDITING

#### Creating a new class

Before you start:

-   make sure you are working on a branch - see quick guide [here](https://docs.google.com/presentation/d/1M8NZQOIQVswng-so6ROxVeMJfDnzth7BYNj_5MXxEik/edit#slide=id.g9db6baf776_1_0).

-   make sure you have the editor's file open in Protege as detailed [here](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/SearchingMondo.md).

New classes are created in the Class hierarchy panel on the left.

There are three buttons at the top of the class hierarchy view. These allow you to add a subclass (L-shaped icon), add a sibling class (c-shaped icon), or delete a selected class (x'd circle).

Practice adding a new term:

We will work on these two tickets:
1.  <https://github.com/monarch-initiative/mondo/issues/616>
2.  <https://github.com/monarch-initiative/mondo/issues/2541> 

#### https://github.com/monarch-initiative/mondo/issues/616

-   Search for the parent term 'hypereosinophilic syndrome' (see [search guide](https://github.com/jamesaoverton/obook/blob/master/04-OntologyTheory/SearchingMondo.md) if you are unsure how to do this).

-   When you are clicked on the term in the Class hierarchy pane, click the add subclass button to add a child class to 'hypereosinophilic syndrome'

![](https://lh6.googleusercontent.com/8Yx82gFh0zvlnoXVnkGerib50qgHcy2V4yYczwL5MRxiJ_XatFkLBAKjJiX9ZyDbyjhDhKx6i1g65o8YvlhABB_Z86mdj1yORgUqImocZm9Y6-sipAisTWhWbHEatGHYGXKEBKI8)

A dialog will popup. Name this new subclass: migratory muscle precursor. Click "OK" to add the class.

![](https://lh3.googleusercontent.com/gMbBBAo_zVdGvXDUBJmMTTZ-bXWCNImi2fcG9CD0d4TBVg5Sx8r4hHr1AAObc6wIM6asK3EIpvlvrVaBkA-y2RGvzuZV80wa-cVJl22WXtweovy-5KI-7v4hwiW5WolyDYr0i_VE)

![](https://lh6.googleusercontent.com/TCbFb62jli65bjmYi-mCfabqtQTEh678Y-4Q6MErJb3fpw_nJ7dxuBPS-9KFqwwMl2Lz1TLQdKdlJ4agHWYv2M4Azo8Qxq7CSKWXHyI4JUCjvcntE1eRwMT_y6npPYzsM7ZcaRsZ)

#### Adding annotations 

Using Protégé you can add annotations such as labels, definitions, synonyms, database cross references (dbxrefs) to any OWL entity. The panel on the right, named Annotations, is where these annotations are added. CL includes a pre-declared set of annotation properties. The most commonly used annotations are below. 

-   rdfs:label
-   definition
-   has_exact_synonym
-   has_broad_synonym
-   has_narrow_synonym
-   has_related synonym
-   database_cross_reference
-   rdfs:comment

Note, most of these are bold in the annotation property list:

![](https://lh5.googleusercontent.com/NL1uWNo9KSETrkPBCCG92Tw6CSsE0oW7qIPZWK6NJ7PJx6YdGE4YxaFEZgN5OfMf8VzTVNmL2whgIv2FvSkYc0ASHM4YfN0l8psVcgjT-5SG2uEDncBUMoCozhP1vjqRyYPnIprS)

Use this panel to add a definition to the class you created. Select the + button to add an annotation to the selected entity. Click on the annotation 'definition' on the left and copy and paste in the definition to the white editing box on the right. Click OK.

Definition: A disorder characterized by episodes of swelling under the skin (angioedema) and an elevated number of the white blood cells known as eosinophils (eosinophilia). During these episodes, symptoms of hives (urticaria), fever, swelling, weight gain and eosinophilia may occur. Symptoms usually appear every 3-4 weeks and resolve on their own within several days. Other cells may be elevated during the episodes, such as neutrophils and lymphocytes. Although the syndrome is often considered a subtype of the idiopathic hypereosinophilic syndromes, it does not typically have organ involvement or lead to other health concerns.

![](https://lh3.googleusercontent.com/4p6jqLqln6U1NHs71h30sdbqfPjSop7KxLJrF_JFfapYPPnBL1A3uA4MHRhqXHUA5YLN7rezy7SD1vNH-KslUWM5qb_Z8PP9IWQJSfg2GzX5XL3aa1CkcAtiR46tETCnwzIXHukm)

![](https://lh4.googleusercontent.com/TP0O04TD6kN1rEn1EM1GcXoWJGz-EsFNihzHSOQi-Q4tq65f1Qpd66ItPFVqn6SuQhDge5PSbiXGz2XwoykEYKxe6f3wwCN0j70bNv3WArJE_wOZSjeMNokuLVEx0r9Odbh0rG9L)

Definitions in Mondo should have a 'database cross reference' (dbxref), which is a reference to the definition source, such as a paper from the primary literature or another database. For references to papers, we cross reference the PubMed Identifier in the format, PMID:XXXXXXXX. (Note, no space)

To add a dbxref to the definition:

-   Click the @ symbol next to the definition
-   Click the + button next in the pop-up window
-   Scroll up on the left hand side until you find 'database_cross_reference', and click it
-   Add the PMID in the editing box (PMID:25527564). _Note: the PMID should not have any spaces)
-   Click OK
-   Add the additional dbxref: GARD:0013029
-   The dbxrefs should appear as below.

![](https://lh6.googleusercontent.com/l589uvv3OKKxrabrqKQdL-NF6PfKi_mSfaz-xk--59WtSD15VOy9CQVZXdE0SHl6ZA761zv9G0UULHF5EKRfMToX2F0kqrwuGbjdnzVV3JRRJbb2l40UjOLeXi-7aM_TBkCSkN3L)

![](https://lh6.googleusercontent.com/aW3quN013aSDfyFXpn-_prKrn0TN7eMzodwK4HdryZ_Zbjade5xZWnFCVt8flkRqIbMy5eT5lKzFEimuGNgJ3YYYybI5rgdcmVWUzzfdwFeXjJSFBpNjqgv27kZVPiazcMiZABn1)

#### Add Synonyms and Database cross reference

1.  Add synonyms 
1.  Click the add annotations button
1.  Add the following synonyms as 'has_exact_synonym': 
1.  EAE
1.  Gleich's syndrome
1.  Gleich syndrome
1.  All synonyms in Mondo should have a dbxref on the synonym
1.  Click the @ symbol next to the synonym
1.  Click the + button
1.  Add the dbxref to each synonym: GARD:0013029
1.  Add database cross reference
1.  Click the add annotations button
1.  Add the following database_cross_reference':
1.  GARD:0013029
1.  Click the @ symbol next to the synonym
1.  Click the + button
1.  Add source: MONDO:equivalentTo

Save your work.
