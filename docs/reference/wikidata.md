/# OBO in Wikidata
## Introduction to Wikidata
* [Wikidata in one page](https://upload.wikimedia.org/wikipedia/commons/8/8d/Wikidata-in-brief-1.0.pdf)
* [Wikidata](https://www.wikidata.org)
* [Wikidata Query Service (UI)](https://query.wikidata.org)
* [Wikidata Query Serivce (Machine readable)](https://query.wikidata.org/sparql)
* [Wikidata API](https://www.wikidata.org/w/api.php)

## OBO in Wikidata
* [Related wikidata OBO properties](https://w.wiki/5nov)
* [Wikidata OBO properties and curation catalogs](https://w.wiki/6TpZ)
* [Related wikidata OBO items](https://w.wiki/6T4v)

## Licenses
On Wikidata the following licenses applies:
"All structured data from the main, Property, Lexeme, and EntitySchema namespaces is available under the Creative Commons CC0 License; text in the other namespaces is available under the Creative Commons Attribution-ShareAlike License" 

Adding non-CC0 licensed OBO ontologies in full might be problematic due to 
* [License stacking](https://mozillascience.github.io/open-data-primers/5.3-license-stacking.html)

IANL, but my understanding is that as long as only URI mappings are created to OBO ontology terms no licenses are breached (even if the ontology is not CC0)


## Why map OBO uris to Wikidata?

* Wikidata is a hub in the Linked Open Data cloud; it is, thus, a good place to crowdsource database cross references (e.g. between the Cell Ontology and FMA).

* Wikidata provides direct links between items and Wikipedia, as well as a proxy for how many different Wikipedia languages are available for each concept. These can be acessed via SPARQL queries  (e.g https://w.wiki/6Tpd). Wikipedia links are useful for adding explainability to applications, and language count can be a proxy for popularity of concepts. 
    * E.g. The top popular concepts with a CL ID are "Cell", "Red Blood Cell" and "Neuron" with over 100 Wikipedia languages each (https://w.wiki/6TyY)


* Wikidata is multilingual and most (if not all) OBO ontologies are English-only. Wikidata provides infrastructure to record preferred labels accross 200+ languages (not sure the current number).

## Notable differences

* Wikidata's model is definition-free. The meaning of Wikidata terms by a combination of the label, description, aliases and statements.

* Wikidata does not support reasoning, as supporting inconsistencies are a feature (not a bug). It is so to handle knowledge diversity. 
*




## Literature
* [Wikidata as a semantic framework for the Gene Wiki initiative](https://scholia.toolforge.org/work/Q23712646)
* [A protocol for adding knowledge to Wikidata: aligning resources on human coronaviruses](https://scholia.toolforge.org/work/Q105037759)

## Tools
* [Scholia](https://scholia.toolforge.org/)
* [Chlambase](https://chlambase.org/)
* [Wikigenomes](http://wikigenomes.org/)
* [Science Stories](http://www.sciencestories.io/)
* [Entity Explosion](https://www.wikidata.org/wiki/Wikidata:Entity_Explosion)
* 
