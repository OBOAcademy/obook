# Linking Data

These are the kinds of things that I do
when I need to work with a new dataset.
My goal is to have data that makes good sense
and that I can integrate with other data
using standard technologies:
Linked Data.

## 0. Before

The boss just sent me this new table to figure out:

datetime | investigator | subject | species | strain | sex | group | protocol | organ | disease | qualifier | comment
---|---|---|---|---|---|---|---|---|---|---|---
1/1/14 10:21 AM | JAO | 12 | RAT | F 344/N | FEMALE | 1 | HISTOPATHOLOGY | LUNG | ADENOCARCINOMA | SEVERE | 
1/1/14 10:30 AM | JO | 31 | MOUSE | B6C3F1 | MALE | 2 | HISTOPATHOLOGY | NOSE | INFLAMMATION | MILD | 
1/1/14 10:45 AM | JAO | 45 | RAT | F 344/N | MALE | 1 | HISTOPATHOLOGY | ADRENAL CORTEX | NECROSIS | MODERATE | 

It doesn't seem too bad,
but there's lots of stuff that I don't quite understand.
Where to start?

## 1. Getting Organized

Before I do anything else,
I'm going to set up a new project for working with this data.
Maybe I'll change my mind later
and want to merge the new project with an existing project,
but it never hurts to start from a nice clean state.

I'll make a new directory in a sensible place
with a sensible name.
In my case I have a `~/Repositories/` directory,
with subdirectories for GitHub and various GitLab servers,
a `local` directory for projects I don't plan to share,
and a `temp` directory for projects that I don't need to keep.
I'm not sure if I'm going to share this work,
so it can go in a new subdirectory of `local`.
I'll call it "linking-data-tutorial" for now.

Then I'll run `git init` to turn that directory into a git repository.
For now I'm just going to work locally,
but later I can make a repository on GitHub
and push my local repository there.

Next I'll create a `README.md` file
where I'll keep notes for myself to read later.
My preferred editor is [Kakoune](https://kakoune.org).

So I'll open a terminal and run these commands:

```sh
$ cd ~/Repositories/local/
$ mkdir linking-data-tutorial
$ cd linking-data-tutorial
$ git init
$ kak README.md
```

In the README I'll start writing something like this:

```markdown
# Linking Data Tutorial

An example of how to convert a dataset to Linked Data.

The source data is available from
<https://github.com/jamesaoverton/obook/tree/master/03-RDF/data.csv>
```

Maybe this information should go somewhere else eventually,
but the README is a good place to start.

"Commit early, commit often" they say, so:

```sh
$ git add README.md
$ git commit -m "Initial commit"
```

## 3. Getting Copies

Data has an annoying tendency to get changed.
You don't want it changing out from under you
while you're in the middle of something.
So the next thing to do is get a copy of the data
and store it locally.
If it's big, you can store a compressed copy.
If it's too big to fit on your local machine,
well keep the best notes you can of how to get to the data,
and what operations you're doing on it.

I'm going to make a `cache` directory
and store all my "upstream" data there.
I'm going to fetch the data and that's it --
I'm **not** going to edit these files.
When I want to change the data I'll make copies in another directory.
I don't want git to track the cached data,
so I'll add `/cache/` to `.gitignore`
and tell git to track *that*.
Then I'll use `curl` to download the file.

```sh
$ mkdir cache
$ echo "/cache/" >> .gitignore
$ git add .gitignore
$ git commit -m "Ignore /cache/ directory"
$ cd cache
$ curl -LO "https://github.com/jamesaoverton/obook/raw/master/03-RDF/data.csv"
$ ls
data.csv
$ cd ..
$ ls -a
.gitignore data README.md
```

## 4. Getting My Bearings

The first thing to do is look at the data.
In this case I have just one table in CSV format,
so I can use any number of tools to open the file and look around.
I bet the majority of people would reach for Excel.
My (idiosyncratic) preference is [VisiData](https://www.visidata.org).

What am I looking for?
A bunch of different things:

- what do the rows represent?
- what columns do I have?
- for each column, what sorts of values do I have?

In my README file I'll make a list of the columns
like this:

```markdown
- datetime
- investigator
- subject
- species
- strain
- sex
- group
- protocol
- organ
- disease
- qualifier
- comment
```

Then I'll make some notes for myself:

```markdown
- datetime: American-style dates, D/M/Y or M/D/Y?
- investigator: initials, ORCID?
- subject: integer ID
- species: common name for species, NCBITaxon?
- strain: alphanumeric
- sex: string female/male
- group: integer ID
- protocol: string, OBI?
- organ: string, UBERON?
- disease: string, DO/MONDO?
- qualifier: string, PATO?
- comment: ???
```

You can see that I'm trying to figure out what's in each column.
I'm also thinking ahead to OBO ontologies that I know of
that may have terms that I can use for each column.

## 5. Getting Structured

In the end, I want to have nice, clean Linked Data.
But I don't have to get there in one giant leap.
Instead I'll take a bunch of small, incremental steps.

There's lots of tools I can use,
but this time I'll use SQLite.

First I'll set up some more directories.
I'll create a `build` directory
where I'll store temporary files.
I don't want git to track this directory,
so I'll add it to `.gitignore`.

```sh
$ mkdir build/
$ echo "/build/" >> .gitignore
$ git add .gitignore
$ git commit -m "Ignore /build/ directory"
```

I'll also add a `src` directory to store code.
I do want to track `src` with git.

```sh
$ mkdir src
$ kak src/data.sql
```

In `src/data.sql` I'll add just enough to import `build/data.csv`:

```sql #src/data.sql
-- import build/data.csv
.mode csv
.import build/data.csv data_csv
```

This will create a `build/data.db` file
and import `build/data.csv` into a `data_csv` table.
Does it work?

```sh
$ sqlite3 build/data.db < src/data.sql
$ sqlite3 build/data.db <<< "SELECT * FROM data_csv LIMIT 1;"
2014-01-01 10:21:00-0500|JAO|12|RAT|F 344/N|FEMALE|1|HISTOPATHOLOGY|LUNG|ADENOCARCINOMA|SEVERE|
```

Nice!

Note that I didn't even specify a schema for `data_csv`.
It uses the first row as the column names,
and the type of every column is `TEXT`.
Here's the schema I end up with:

```sh
$ sqlite3 build/data.db <<< ".schema data_csv"
CREATE TABLE data_csv(
  "datetime" TEXT,
  "investigator" TEXT,
  "subject" TEXT,
  "species" TEXT,
  "strain" TEXT,
  "sex" TEXT,
  "group" TEXT,
  "protocol" TEXT,
  "organ" TEXT,
  "disease" TEXT,
  "qualifier" TEXT,
  "comment" TEXT
);
```

I'm going to want to update `src/data.sql`
then rebuild the database over and over.
It's small, so this will only take a second.
If it was big,
then I would copy a subset into `build/data.csv` for now
so that I the script still runs in a second or two
and I can iterate quickly.
I'll write a `src/build.sh` script to make life a little easier:

```sh
#!/bin/sh

rm -f build/*
cp cache/data.csv build/data.csv
sqlite3 build/data.db < src/data.sql
```

Does it work?

```sh
$ sh src/build.sh
```

Nice!
Time to update the README:

```markdown
## Requirements

- [SQLite3](https://sqlite.org/index.html)

## Usage

Run `sh src/build.sh`
```

I'll commit my work in progress:

```sh
$ git add src/data.sql src/build.sh
$ git add --update
$ git commit -m "Load data.csv into SQLite"
```

Now I have a script
that executes a SQL file
that loads the source data into a new database.
I'll modify the `src/data.sql` file
in a series of small steps
until it has the structure that I want.

## 6. Getting Clean

In the real world, data is always a mess.
It takes real work to clean it up.
And really, it's almost never perfectly clean.

It's important to recognize that cleaning data has diminishing returns.
There's low hanging fruit:
easy to clean, often with code, and bringing big benefits.
Then there's tough stuff
that requires an expert to work through the details,
row by row.

The first thing to do is figure out the schema you want.
I'll create a new `data` table
and start with the default schema from `data_csv`.
Notice that in the default schema all the column names are quoted.
That's kind of annoying.
But when I remove the quotation marks
I realize that one of the column names is "datetime",
but `datetime` is a keyword in SQLite!
You can't use it as a column name without quoting.
I'll rename it to "assay_datetime".
I have the same problem with "group".
I'll rename "group" to "group_id"
and "subject" to "subject_id".
The rest of the column names seem fine.

I want "assay_datetime" to be in standard ISO datetime format,
but SQLite stores these as TEXT.
The "subject" and "group" columns are currently integers,
but I plan to make them into URIs to CURIEs.
So everything will still be TEXT.

```sql
CREATE TABLE data(
  assay_datetime TEXT,
  investigator TEXT,
  subject_id TEXT,
  species TEXT,
  strain TEXT,
  sex TEXT,
  group_id TEXT,
  protocol TEXT,
  organ TEXT,
  disease TEXT,
  qualifier TEXT,
  comment TEXT
);
```

The dates currently look like "1/1/14 10:21 AM".
Say I know that they were done on Eastern Standard Time.
How do I convert to ISO dates like "2014-01-01 10:21:00-0500"?
Well SQLite isn't the right tool for this.
The Unix `date` command does a nice job, though:

```sh
$ date -d "1/1/14 10:21 AM EST" +"%Y-%m-%d %H:%M:%S%z"
2014-01-01 10:21:00-0500
```

I can run that over each line of the file using `awk`.
So I update the `src/build.sh`
to rework the `build/data.csv` before I import:

```sh #src/build.sh
#!/bin/sh

rm -f build/*

head -n1 cache/data.csv > build/data.csv
tail -n+2 cache/data.csv \
| awk 'BEGIN{FS=","; OFS=","} {
  "date -d \""$1" EST\" +\"%Y-%m-%d %H:%M:%S%z\"" | getline $1;
  print $0
}' \
>> build/data.csv

sqlite3 build/data.db < src/data.sql
```

One more problem I could clean up
is that "JO" should really be "JAO" --
that's just a typo,
and they should both refer to James A. Overton.
I could make that change in `src/build.sh`,
but I'll do it in `src/data.sql` instead.
I'll write a query to copy all the rows of `data_csv` into `data`
and then I'll update `data` with some fixes.

```sql
-- copy from data_csv to data
INSERT INTO data SELECT * FROM data_csv;

-- clean data
UPDATE data SET investigator="JAO" WHERE investigator="JO";
```

Honestly, it took me quite a while to write that `awk` command.
It's a very powerful tool,
but I don't use it enough to remember how it works.
You might prefer to write yourself a Python script, or some R code.
You could use that instead of this SQL UPDATE as well.
I just wanted to show you two of the thousands of ways to do this.
If there's a lot of replacements like "JO",
then you might also consider listing them in another table
that you can read into your script.

The important part is to *automate* your cleaning!

Why didn't I just edit `cache/data.csv` in Excel?
In step 2 I saved a copy of the data
because I didn't want it to change while I was working on it,
but I *do* expect it to change!
By automating the cleaning process,
I should be able to just update `cache/data.csv`
run everything again,
and the fixes will be applied again.
I don't want to do all this work manually
every time the upstream data is updated.

I'll commit my work in progress:

```sh
$ git add --update
$ git commit -m "Start cleaning data"
```

Cleaning can take a lot of work.
This is example table is pretty clean already.
The next hard part is sorting out your terminology.

## 7. Getting Connected

It's pretty easy to convert a table *structure* to triples.
The hard part is converting the table *contents*.
There are some identifiers in the table that would be better as URLs,
and there's a bunch of terminology that would be better
if it was linked to an ontology or other system.

I'll start with the identifiers that are *local* to this data:
subject_id and group_id.
I can convert them to URLs by defining a prefix
and then just using that prefix.
I'll use string concatenation to update the table:

```sql 
-- update subject and groupd IDs
UPDATE data SET subject_id="ex:subject-" || subject_id;
UPDATE data SET group_id="ex:group-" || group_id;
```

Now I'll check my work:

```sh
$ sqlite3 build/data.db <<< "SELECT * FROM data_csv LIMIT 1;"
2014-01-01 10:21:00-0500|JAO|ex:subject-12|RAT|F 344/N|FEMALE|ex:group-1|HISTOPATHOLOGY|LUNG|ADENOCARCINOMA|SEVERE|
```

The next thing is to tackle the terminology.
First I'll just make a list of the terms I'm using
from the relevant columns in `build/term.tsv`:

```sh #collect
$ sqlite3 build/data.db << EOF > build/term.tsv
SELECT investigator FROM data
UNION SELECT species FROM data
UNION SELECT strain FROM data
UNION SELECT strain FROM data
UNION SELECT sex FROM data
UNION SELECT protocol FROM data
UNION SELECT organ FROM data
UNION SELECT disease FROM data
UNION SELECT qualifier FROM data;
EOF
```

It's a lot of work to go through all those terms
and find good ontology terms.
I'm going to do that hard work for you
(just this once!)
so we can keep moving.
I'll add this table to `src/term.tsv`

id | code | label
---|---|---
obo:NCBITaxon_10116 | RAT | Rattus norvegicus
obo:NCBITaxon_10090 | MOUSE | Mus musculus
ex:F344N | F 344/N | F 344/N
ex:B6C3F1 | B6C3F1 | B6C3F1
obo:PATO_0000383 | FEMALE | female
obo:PATO_0000384 | MALE | male
obo:OBI_0600020 | HISTOPATHOLOGY | histology
obo:UBERON_0002048 | LUNG | lung
obo:UBERON_0007827 | NOSE | external nose
obo:UBERON_0001235 | ADRENAL CORTEX | adrenal cortex
obo:MPATH_268 | ADENOCARCINOMA | adenocarcinoma
obo:MPATH_212 | INFLAMMATION | inflammation
obo:MPATH_4 | NECROSIS | necrosis
obo:PATO_0000396 | SEVERE | severe intensity
obo:PATO_0000394 | MILD | mild intensity
obo:PATO_0000395 | MODERATE | moderate intensity
orcid:0000-0001-5139-5557 | JAO | James A. Overton

And I'll add these prefixes to `src/prefix.tsv`:

prefix | base
---|---
rdf | http://www.w3.org/1999/02/22-rdf-syntax-ns#
rdfs | http://www.w3.org/2000/01/rdf-schema#
xsd | http://www.w3.org/2001/XMLSchema#
owl | http://www.w3.org/2002/07/owl#
obo | http://purl.obolibrary.org/obo/
orcid | http://orcid.org/
ex | https://example.com/
subject | https://example.com/subject/
group | https://example.com/group/

Now I can import these tables into SQL
and use the term table as a FOREIGN KEY constraint
on data:

```sql #src/data.sql
.mode tabs

CREATE TABLE prefix (
  prefix TEXT PRIMARY KEY,
  base TEXT UNIQUE
);
.import --skip 1 src/prefix.tsv prefix

CREATE TABLE term (
  id TEXT PRIMARY KEY,
  code TEXT UNIQUE,
  label TEXT UNIQUE
);
.import --skip 1 src/term.tsv term

CREATE TABLE data(
  assay_datetime TEXT,
  investigator TEXT,
  subject_id TEXT,
  species TEXT,
  strain TEXT,
  sex TEXT,
  group_id TEXT,
  protocol TEXT,
  organ TEXT,
  disease TEXT,
  qualifier TEXT,
  comment TEXT,
  FOREIGN KEY(investigator) REFERENCES term(investigator),
  FOREIGN KEY(species) REFERENCES term(species),
  FOREIGN KEY(strain) REFERENCES term(strain),
  FOREIGN KEY(sex) REFERENCES term(sex),
  FOREIGN KEY(protocol) REFERENCES term(protocol),
  FOREIGN KEY(organ) REFERENCES term(organ),
  FOREIGN KEY(disease) REFERENCES term(disease),
  FOREIGN KEY(qualifier) REFERENCES term(qualifier)
);

-- copy from data_csv to data
INSERT INTO data SELECT * FROM data_csv;

-- clean data
UPDATE data SET investigator="JAO" WHERE investigator="JO";

-- update subject and groupd IDs
UPDATE data SET subject_id="ex:subject-" || subject_id;
UPDATE data SET group_id="ex:group-" || group_id;
```

I'll update the README:

```markdown
See `src/` for:

- `prefix.tsv`: shared prefixes
- `term.tsv`: terminology
```

I'll commit my work in progress:

```sh
$ git add src/prefix.tsv src/term.tsv
$ git add --update
$ git commit -m "Add and apply prefix and term tables"
```

Now all the terms are linked to controlled vocabularies
of one sort or another.
If I want to see the IDs for those links instead of the "codes"
I can define a VIEW:

```sql #src/data.sql
CREATE VIEW linked_data_id AS
SELECT assay_datetime,
  investigator_term.id AS investigator,
  subject_id,
  species_term.id AS species,
  strain_term.id AS strain,
  sex_term.id AS sex,
  group_id,
  protocol_term.id AS protocol,
  organ_term.id AS organ,
  disease_term.id AS disease,
  qualifier_term.id AS qualifier
FROM data
JOIN term as investigator_term ON data.investigator = investigator_term.code
JOIN term as species_term ON data.species = species_term.code
JOIN term as strain_term ON data.strain = strain_term.code
JOIN term as sex_term ON data.sex = sex_term.code
JOIN term as protocol_term ON data.protocol = protocol_term.code
JOIN term as organ_term ON data.organ = organ_term.code
JOIN term as disease_term ON data.disease = disease_term.code
JOIN term as qualifier_term ON data.qualifier = qualifier_term.code;
```

I'll check:

```sh
$ sqlite3 build/data.db <<< "SELECT * FROM linked_ids LIMIT 1;"
2014-01-01 10:21:00-0500|orcid:0000-0001-5139-5557|ex:subject-12|obo:NCBITaxon_10116|ex:F344N|obo:PATO_0000383|ex:group-1|obo:OBI_0600020|obo:UBERON_0002048|obo:MPATH_268|obo:PATO_0000396
```

I can also define a similar view for their "official" labels:
 
```sql #src/data.sql
CREATE VIEW linked_data_label AS
SELECT assay_datetime,
  investigator_term.label AS investigator,
  subject_id,
  species_term.label AS species,
  strain_term.label AS strain,
  sex_term.label AS sex,
  group_id,
  protocol_term.label AS protocol,
  organ_term.label AS organ,
  disease_term.label AS disease,
  qualifier_term.label AS qualifier
FROM data
JOIN term as investigator_term ON data.investigator = investigator_term.code
JOIN term as species_term ON data.species = species_term.code
JOIN term as strain_term ON data.strain = strain_term.code
JOIN term as sex_term ON data.sex = sex_term.code
JOIN term as protocol_term ON data.protocol = protocol_term.code
JOIN term as organ_term ON data.organ = organ_term.code
JOIN term as disease_term ON data.disease = disease_term.code
JOIN term as qualifier_term ON data.qualifier = qualifier_term.code;
```

I'll check:

```sh
$ sqlite3 build/data.db <<< "SELECT * FROM linked_data_label LIMIT 1;"
2014-01-01 10:21:00-0500|James A. Overton|ex:subject-12|Rattus norvegicus|F 344/N|female|ex:group-1|histology|lung|adenocarcinoma|severe intensity
```

I'll commit my work in progress:

```sh
$ git add --update
$ git commit -m "Add linked_data tables"
```

Now the tables use URLs and is connected to ontologies and stuff.
But are we Linked yet?

## 8. Getting Triples

SQL tables aren't an official Linked Data format.
Of all the RDF formats, I prefer Turtle.
It's tedious but not difficult to get Turtle out of SQL.
These query do what I need them to do,
but note that if the literal data contained quotation marks
(for instance)
then I'd have to do more work to escape those.
First I create a triple table:

```sql #src/data.sql
CREATE TABLE triple (
  subject TEXT,
  predicate TEXT,
  object TEXT,
  literal INTEGER -- 0 for object IRI, 1 for object literal
);

-- create triples from term table
INSERT INTO triple(subject, predicate, object, literal)
SELECT id, "rdfs:label", label, 1
FROM term;

-- create triples from data table
INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-assay_datetime", assay_datetime, 1
FROM data;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-investigator", term.id, 0
FROM data
JOIN term AS term ON data.investigator = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-subject_id", subject_id, 0
FROM data;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-species", term.id, 0
FROM data
JOIN term AS term ON data.species = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-strain", term.id, 0
FROM data
JOIN term AS term ON data.strain = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-sex", term.id, 0
FROM data
JOIN term AS term ON data.sex = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-group_id", group_id, 0
FROM data;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-protocol", term.id, 0
FROM data
JOIN term AS term ON data.protocol = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-organ",term.id, 0
FROM data
JOIN term AS term ON data.organ= term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-disease", term.id, 0
FROM data
JOIN term AS term ON data.disease = term.code;

INSERT INTO triple(subject, predicate, object, literal)
SELECT "ex:assay-" || data.rowid, "ex:column-qualifier", term.id, 0
FROM data
JOIN term AS term ON data.qualifier = term.code;
```

Then I can turn triples into Turtle
using string concatenation:

```sql #src/turtle.sql
SELECT "@prefix " || prefix || ": <" || base || "> ."
FROM prefix
UNION ALL
SELECT ""
UNION ALL
SELECT subject || " " ||
  predicate || " " ||
  CASE literal
    WHEN 1 THEN """" || object || """"
    ELSE object
  END
  || " . "
FROM triple;
```

I can add this to the `src/build.sh`:

```sh #src/build.sh
sqlite3 build/data.db < src/turtle.sql > build/data.ttl
```

Here's just a bit of that `build/data.ttl` file:

```ttl
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

orcid:0000-0001-5139-5557 rdfs:label "James A. Overton" .
assay:1 column:assay_datetime "2014-01-01 10:21:00-0500"^^xsd:datetime .
assay:1 column:investigator orcid:0000-0001-5139-5557 .
```

SQL is not a particularly expressive language.
Building the triple table is straightforward but verbose.
I could have done the same thing with much less Python code.
(Or I could have been clever and generated some SQL to execute!)

I'll commit my work in progress:

```sh
$ git add src/turtle.sql
$ git add --update
$ git commit -m "Convert to Turtle"
```

So technically I have a Turtle file.
Linked Data!
Right?
Well, it's kind of "flat".
It still looks more like a table than a graph.

## 9. Getting Linked

The table I started with is very much focused on the data:
there was some sort of assay done,
and this is the information that someone recorded about it.
The Turtle I just ended up with is basically the same.

Other people may have assay data.
They may have tables that they converted into Turtle.
So can I just merge them?
Technically yes:
I can put all these triples in one graph together.
But I'll still just have "flat" chunks of data
representing rows
sitting next to other rows,
without really linking together.

The next thing I would do with this data
is reorganized it based on the *thing* it's talking about.
I know that:

- there was an assay
- the assay was performed at a certain time,
  using a certain protocol
- there was a person who performed the assay
- there was a subject animal of some species, strain, and sex
- the subject animal belonged to a study group
- the subject animal had some organs
- the assay resulted in some measurements

Most of these are things that I could point to in the world,
or could have pointed to
if I was in the right place at the right time.

By thinking about these things,
I'm stepping beyond what it was convenient for someone to record,
and thinking about what happened in the world.
If somebody else has some assay data,
then they might have recorded it differently
for whatever reason,
and so it wouldn't line up with my rows.
I'm trying my best to use the same terms for the same things.
I also want to use the same "shapes" for the same things.
When trying to come to an agreement about what is connected to what,
life is easier if I can point to the things I want to talk about:
"See, here is the person, and the mouse came from here, and he did this and this."

I could model the data in SQL
by breaking the big table into smaller tables.
I could have tables for:

- person
- group
- subject: species, strain, sex, group
- assay: date, investigator, subject, protocol
- measurement: assay, organ, disease, qualifier

Then I would convert each table to triples more carefully.
That's a good idea.
Actually it's a better idea than what I'm about to do...

Since we're getting near the end,
I'm going to show you how you can do that modelling in SPARQL.
SPARQL has a CONSTRUCT operation that you use to build triples.
There's lots of tools that I could use to run SPARQL
but I'll use [ROBOT](http://robot.obolibrary.org).
I'll start with the "flat" triples in `build/data.ttl`,
select them with my WHERE clause,
then CONSTRUCT better triples,
and save them in `build/model.ttl`.

```sparql #src/model.rq
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX ex: <https://example.com/>

CONSTRUCT {
  ?group
    rdfs:label      ?group_label .
  ?subject
    rdf:type        ?species ;
    rdfs:label      ?subject_label ;
    ex:strain       ?strain ;
    obo:RO_0000086  ?sex ;         # has quality
    ex:group        ?group .
  ?sex
    rdf:type        ?sex_type ;
    rdfs:label      ?sex_label .
  ?organ
    rdf:type        ?organ_type ;
    rdfs:label      ?organ_label ;
    obo:BFO_0000050 ?subject .     # part of
  ?assay
    rdf:type        ?assay_type ;
    rdfs:label      ?assay_label ;
    obo:OBI_0000293 ?subject ;     # has specified input
    obo:IAO_0000136 ?organ .       # is about
}
WHERE {
  ?subject_row
    ex:column-assay_datetime ?datetime ;
    ex:column-investigator   ?investigator ;
    ex:column-subject_id     ?subject ;
    ex:column-species        ?species ;
    ex:column-sex            ?sex_type ;
    ex:column-group_id       ?group ;
    ex:column-protocol       ?assay_type ;
    ex:column-organ          ?organ_type ;
    ex:column-disease        ?disease ;
    ex:column-qualifier      ?qualifier .

  ?assay_type
    rdfs:label ?assay_type_label .
  ?sex_type
    rdfs:label ?sex_type_label .
  ?organ_type
    rdfs:label ?organ_type_label .

  BIND (URI(CONCAT(STR(?subject), "-assay")) AS ?assay)
  BIND (URI(CONCAT(STR(?subject), "-sex"))   AS ?sex)
  BIND (URI(CONCAT(STR(?subject), "-organ")) AS ?organ)
  BIND (CONCAT("subject ", REPLACE(STR(?subject), "^.*-", "")) AS ?subject_label)
  BIND (CONCAT("group ", REPLACE(STR(?group), "^.*-", ""))     AS ?group_label)
  BIND (CONCAT(?subject_label, " ", ?assay_type_label)    AS ?assay_label)
  BIND (CONCAT(?subject_label, " sex: ", ?sex_type_label) AS ?sex_label)
  BIND (CONCAT(?subject_label, " ", ?organ_type_label)    AS ?organ_label)
}
```

I can add this to the `src/build.sh`:

```sh #src/build.sh
java -jar robot.jar query \
  --input build/data.ttl \
  --query src/model.rq build/model.ttl
```

Then I get `build/model.ttl` that looks (in part) like this:

```ttl
ex:subject-31  a        obo:NCBITaxon_10090 ;
        rdfs:label      "subject 31" ;
        obo:RO_0000086  ex:subject-31-sex ;
        ex:group        ex:group-2 .

ex:group-2  rdfs:label  "group 2" .
```

Now that's what I call Linked Data!

I'll update the README:

```markdown
## Modelling

The data refers to:

- investigator
- subject
- group
- assay
- measurement data
  - subject organ
  - disease

TODO: A pretty diagram.
```

I'll commit my work in progress:

```sh
$ git add src/model.rq
$ git add --update
$ git commit -m "Build model.ttl"
```

## 10. Getting It Done

That was a lot of work for a small table.
And I did all the hard work of mapping
the terminology to ontology terms for you!

There's lots more I can do.
The SPARQL is just one big chunk,
but it would be better in smaller pieces.
The modelling isn't all that great yet.
Before changing that
I want to run it past the boss
and see what she thinks.

It's getting close to the end of the day.
Before I quit I should update the README,
clean up anything that's no longer relevant or correct,
and make any necessary notes to my future self:

```sh
$ git add --update
$ git commit -m "Update README"
$ quit
```

