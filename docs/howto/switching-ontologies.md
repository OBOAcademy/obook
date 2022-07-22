# Switching Ontologies in Protege
By: [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432)

## Description
When you edit an ontology, you need to make sure you are using the correct prefix and your assigned ID range for that on ontology. Protege (unfortunately) does
not remember the last prefix or ID range that you used when you switch between ontologies. Therefore we need to manually update this each time we switch ontologies.

## Instructions
1. When you switch to a new ontology file, open your preferences in Protege (File -> Preferences).
2. Be sure you are on the **New entities** tab.
3. Add the Prefix for the ontology you are working on.
4. If you don't know your ID range, go to the ID ranges file for that ontology (it should be in `src/ontology/[ontology-name]-idranges.owl`. (For example, src/ontology/mondo-idranges.owl.)
5. Copy and paste in the start and end values for your ID range.

![image](https://user-images.githubusercontent.com/6722114/135540561-c16cd127-a9d7-4192-88b0-f323bf0c918f.png)

### Tips
1. I work on many ontologies, so I keep a note in OneNote (or Evernote) that keeps track of all my ID ranges for quick reference.
2. You don't need to track the last ID that was used, Protege will know to pick the next ID in your range. For example, if your ID range is 8000000 to 8999999, you can enter that as your range, even if you have already added 10 terms within your range. Protege will know to assign the next ID as 8000011.

## Video Explanation

Available [here](https://www.youtube.com/watch?v=ttK_3z_PJ4E).

<iframe width="560" height="315" src="https://www.youtube.com/watch?v=ttK_3z_PJ4E&feature=youtu.be" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

