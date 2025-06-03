# XML Catalogs demystified

The XML catalog is a file that tells tools like `robot` and Protégé where to find locally-stored OWL files when processing imports. It is a relatively simple, but important, piece of infrastructure that is vital for managing ontology imports. 

Here is a sample line from an XML catalog:

`<uri name="https://w3id.org/elmo/elmo/imports/ro_import.owl" uri="imports/ro_import.owl"/>`

This tells the tool that if it sees the URI `https://w3id.org/elmo/elmo/imports/ro_import.owl`, replace that with `imports/ro_import.owl` which will access the local file. It is essentially redirecting internal requests from `https://w3id.org/elmo/elmo/imports/ro_import.owl` to the local file.

An XML catalog is used in the [ODK](odk.md) to manage imports so that the tool does not have to constantly re-download imported ontologies. 

Here are some additional resources about XML catalogs:

- `robot` [XML Catalogs documentation](https://robot.obolibrary.org/global.html#xml-catalogs)
- [Protégé and XML Catalogs](https://protegewiki.stanford.edu/wiki/Importing_Ontologies_in_P41#Protege_and_XML_Catalogs)