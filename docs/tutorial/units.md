# Units of Measurement

Units of measurement are among the most fundamental standards that make science, commerce, and much of our daily lives possible. Take a moment to think of some examples of units of measurement that you use in your work and daily life. Write down a few, and we'll come back to your list with some questions at the end.

Despite their foundational status and familiarity, units of measurement can be difficult to use in information processing systems such as databases, programming languages, and the semantic web. Data integration of quantitative values is harder than it should be. In this article we'll consider some of the problems and solutions, and end with a short list of practical advice.


## Writing Down Quantitative Values

When communicating with humans, we usually write down quantitative values as a number and unit, e.g. "12m", "35 kg". When dealing with computers, we need to be more pedantic. Do we want to represent our quantitative values as:

1. a single combined value, e.g. the string `"12m"`
2. a pair of values, a number and a string or symbol, e.g. `[12, "m"]`
3. a larger complex, such as a number and a complex of symbols for the unit, e.g. `[35, k, g]`

The biggest advantage of separating out the numeric part is that we can do numeric operations such as greater-than-or-equal-to which would not be possible with option (1). We can also check the unit part to ensure that we're comparing identical units. Using the pair of a number and a string or symbol for the (combined) unit strikes a good balance.


## A Number of Problems

Even the number part of a quantitative value is not quite as simple as it seems. Mathematicians, computer hardware and software designers, and scientists all have different perspectives and techniques for working with numbers, and sometimes these do not line up.

There's more than one kind of number. Most quantitative values can be represented by real numbers, but some just need integers. It took mathematicians a few thousand years to provide really clear rules for integers and real numbers.

There's a "countably infinite" number of integers and an "uncountably infinite" number of real numbers, but our computers are finite. Our programs limit the numbers that they can represent to strict types that can be represented in binary, e.g. 32 bit signed integer, 64 bit unsigned integer, double precision floating point number. Computer scientists and hardware designers put a lot of work into the theory and practice of how computers crunch numbers. When moving data between programming languages, databases, or data formats, you sometimes do need to be careful about how numbers are converted from one format to another. When running calculations, the rules of specific numeric types and floating point arithmetic can ruin your day.

Not only do mathematicians and programmers have different ideas about how numbers need to work, but scientists also have special rules about how numbers are used for measurements and for representing uncertainty. High-school science students are taught rules about significant digits. Publications and plots include uncertainty values and error bars. By default, most software systems do not account for these, and this can be particularly problematic when converting from one system of units to another.

Some databases and software tools support numeric ranges, with closed or open bounds, and operators to make use of them. This provides another layer of power and complexity, which may help to handle quantitative values, or just confuse things further.

Above we recommended using pairs of numbers and units to represent quantitative values, but that separation leaves us open to mistakes where we sort or search by the numeric part and forget to account for differences in units. Bugs in unit conversion have been known to crash very expensive spacecraft.

Most of the time you don't need anything fancy from your numbers, but when you do, be careful and check your work.


## Sorts of Units

The unit part of a quantitative value can be at least as complicated as the numeric part, with fewer standards to go by.

While not exhaustive, let's narrow our discussion to three very broad, very rough sorts of units:

1. "metric" (Système International, SI) units
2. "historical" units
3. "biomedical" units

The metric system is the dominant system of units across the globe for physical sciences, engineering, trade, and many other fields. It is well-defined and has wide scope, but not everything we want to measure has a metric unit.

One other limitation, which is important for our purposes, is that there aren't any official URLs for metric units. This makes it a bit trickier than it should be to use the metric system with linked data, RDF, OWL, and the semantic web.

Our "historical" group includes the various units that the metric system replaced, and others that fell out of favour. Some of these are only of interest for historical datasets, but I will (controversially?) include "imperial" units such as miles, feet, pounds, and ounces, which are still used today.

Biomedicine often uses metric or historical units, but also has many other units for counting things, measuring rates (e.g. heart rate), and ratios (e.g. blood sugar, body mass index).

Other fields may have units beyond these three groups, but this is already enough for us to chew on today.


## Unit Codes

We're used to writing down units as short codes. These codes have their own rules that we need to keep in mind.

Let's start by stipulating that there are some "base units", such as "m" for metre, "s" for second, foot, pound, "nm" for nautical mile, etc.

We can often compose these units using multiplication or division, and "m/s" get metres per second, or foot pounds (of torque). We can compose units with themselves and then use exponent notation, e.g. "m/s²" for metres per second squared. Superscripts are often difficult to use with software or programming languages, so some systems do not bother with them: `m/s2`. Division can be expressed by negative exponents, so `m.s-2` can also express metres per second squared -- the `.` indicates multiplication, avoiding ambiguity with `ms` for milliseconds. Now we have two ways of writing the same composed unit: division and multiplication with negative exponents. Multiplication is associative, so in theory the order of the units can vary, allowing for more ways to write the same thing.

Then there are the familiar prefixes for indicating powers of ten: "m" milli, "k" kilo, "M" mega, etc. These are an essential part of the metric system, but also used in other systems.

These simple rules can generate an infinite number of possible units, and while there is no practical use for the vast majority of all the *possible* units, in practice it's hard to draw a reasonable boundary around the set of units that someone might want to use.

The metric system has clear rules for base units, prefixes, and composition. When it comes to historical units, the Unified Code for Units of Measure (UCUM, <https://ucum.org>) combines metric and many historical units into a combined system that extends these rules. Like the metric system, in principle this allows for an unlimited number of possible units.

What about the biomedical units we care about? UCUM provides a system for "non-units" indicated by curly brackets `{}` that allows arbitrary extension, e.g. `{cell}/ml` for cells per millilitre.

UCUM has good coverage of metric and historical units, and the non-units provide a flexible way to include the "biomedical" group. The next two concerns are:

1. the UCUM license <https://ucum.org/license>
2. using UCUM on the semantic web

For 2 we would like to have standard URLs that resolve to more information about units, but UCUM does not provide them. This would have to work for the unlimited number of complex units that the UCUM system can generate.


## Unit Ontologies

Several ontologies have been developed to help use units of measurement with RDF, OWL, linked data, and the semantic web.

- [QUDT](https://www.qudt.org) grew out of NASA to provide units for science and engineering. It's coverage of these is thorough, but it does not include historical or biological units

- [OBOE](https://github.com/NCEAS/oboe) Extensible Observation Ontology is a standard that grew out of the ecology domain, and includes units from all three groups

- [OM](https://github.com/HajoRijgersberg/OM), the Ontology for Units of Measure, includes all three sorts of units we are interested in

- [UO](https://github.com/bio-ontology-research-group/unit-ontology), the Units of Measurement Ontology, was developed to support use cases in the OBO community, and has more focus on biomedical units than the others listed here

Some of these ontologies include UCUM codes, which will be relevant in a moment.

Unfortunately there are some problems here:

1. No one of these ontologies provides complete coverage of all the metric, historical, and biomedical units that we need
2. All these projects model units of measurement in different ways
3. The unlimited composition of complex units is a problem for any unit ontology build with OWL

While QUDT has the widest support, it has the narrowest scope. OM and UO have wider scope but much narrower community support, with OBOE somewhere in the middle. UCUM has the widest scope and the widest support, but does not integrate with the semantic web.


## UoM

[units-of-measurement.org](https://units-of-measurement.org)

The UoM project aims to provide URLs for UCUM codes that resolve to linked data web pages. These pages link to RDF/OWL representations, and to other unit ontologies when they are available. The bridge to these other ontologies is the annotations with UCUM codes that they provide. UoM implements a UCUM parser that can handle the unlimited combinations that UCUM allows -- although there are, of course, practical limitations to the system.

For example, [`m.s-2`](https://units-of-measurement.org/m.s-2):

```turtle
@prefix NERC_P06: <http://vocab.nerc.ac.uk/collection/P06/current/> .
@prefix OM: <http://www.ontology-of-units-of-measure.org/resource/om-2/> .
@prefix QUDT: <http://qudt.org/vocab/unit/> .
@prefix UO: <http://purl.obolibrary.org/obo/UO_> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix unit: <https://w3id.org/uom/> .

unit:SI_code a owl:AnnotationProperty ;
    rdfs:label "SI code" .

unit:UCUM_code a owl:AnnotationProperty ;
    rdfs:label "UCUM code" .

unit:m.s-2 a owl:NamedIndividual ;
    rdfs:label "metre per square second"@en ;
    skos:altLabel "meter per square second"@en ;
    skos:definition "A unit which is equal to 1 metre per 1 square second."@en ;
    skos:exactMatch UO:0000077,
        QUDT:M-PER-SEC2,
        NERC_P06:MPS2,
        OM:metrePerSecond-TimeSquared ;
    unit:SI_code "m s-2" ;
    unit:UCUM_code "m.s-2",
        "m/s2" .
```

The first step to providing URLs for UCUM codes is to "URL escape" (i.e. "percent encode") any characters that are excluded from URLs or have special meanings, especially `/`.

The second step is to pick a single normal form. UCUM allows multiple ways to write the same unit, such as "m/s" and "m.s-1". Most semantic web system compare URLs by string identity, so it is important to have a single normalized form. Since `/` is a special character for URLs, we chose to use exponents throughout, sorting from most positive to most negative exponent, and sorting alphabetically when exponents are the same.

The third step is to provide labels for each unit. Since arbitrary compositions of units are possible, this is a little tricky. We currently support English labels, and would like to support more.

The UoM system is still a work in progress. It likely contains some bugs, and UCUM non-units (`{}`) are not yet supported. If you would like to help finish this project, help would be appreciated!


## Units in Practice

Here's my practical advice:

1. If you only use metric units, stick to metric units, otherwise use UCUM

2. If you need a UCUM non-unit, try to use an OBO ontology label

3. Treat your quantitative values as the pair of a unit and a metric or UCUM code:
    - an 2-tuple or array of length 2: `[12, "m"]`
    - two columns in a database
    - two keys in a dictionary/object
    - a subject with two triples in RDF

4. If your units never change, consider building the unit part into the column name, dictionary key, RDF predicate, or OWL property, e.g. "height in m"

5. Be careful with your numeric types

6. If you need URLs for UCUM, use units-of-measurement.org

7. Consider using LinkML and one of these patterns for ['How to model quantities and measurements'](https://linkml.io/linkml/howtos/model-measurements.html)


## Are We There Yet?

Look back at the list of units you wrote down at the beginning:

- Are they all metric?
- If not, are they all in UCUM?
- If not, could they fit in UCUM with non-units?
- If they use non-units, can those be found in OBO?
- If not, can they be added to OBO?

