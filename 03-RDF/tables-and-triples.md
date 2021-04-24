# Tables and Triples

Tables and triples seem very different.
Tables are familiar and predictable.
Triples are weird and floppy.
SQL is normal, SPARQL is bizarre, at least at first.

Tables are great, and they're the right tool for a lot of jobs,
but they have their limitations.
Triples shine when it comes to merging heterogeneous data.
But it turns out that there's a clear path from tables to triples,
which should help make RDF make more sense.

## Tables

Tables are great!
Here's a table!

first_name | last_name
---|---
Luke | Skywalker
Leia | Organa
Darth | Vader
Han | Solo

You won't be surprised to find out
that tables have *rows* and *columns*.
Often each row corresponds to some thing
that we want to talk about,
such as a fictional character from *Star Wars*.
Each column usually corresponds to some sort of property
that those things might have.
Then the cells contain the values of those properties
for their respective row.
We take some sort of complex information about the world,
and we break it down along two dimensions:
the things (rows) and their properties (columns).

## Primary Keys

Tables are great!
We can add another name to our table:

first_name | last_name
---|---
Luke | Skywalker
Leia | Organa
Darth | Vader
Han | Solo
Anakin | Skywalker

Hmm.
That's a perfectly good table,
but it's not capturing the information that we wanted.
It turns out (**Spoiler Alert!**) that Anakin Skywalker *is* Darth Vader!
We might have thought that the rows of our table
were describing individual people,
but it turns out that they're just describing individual names.
A person can change their name
or have more than one name.

We want some sort of identifier
that lets us pick out the same person,
and distinguish them from all the other people.
Sometimes there's a "natural key" that we can use for this purpose:
some bit of information that uniquely identifies a thing.
When we don't have a natural key, we can generate an "artificial key".
Random strings and number can be good artificial keys,
but sometimes a simple incrementing integer is good enough.

The main problem with artificial keys
is that it's our job to *maintain the link*
between the thing and the identifier that we gave it.
We prefer natural keys because we just have to inspect that thing
(in some way)
to figure out what to call it.
Even when it's possible,
sometimes that's too much work.
Maybe we could use a DNA sequence as a natural key for a person,
but it probably isn't practical.
We do use fingerprints and facial recognition,
for similar things, though.

(Do people in *Star Wars* even have DNA?
Or just midichlorions?)

Let's add a column with an artificial key to our table:

sw_id | first_name | last_name
---|---|---
1 | Luke | Skywalker
2 | Leia | Organa
3 | Darth | Vader
4 | Han | Solo
3 | Anakin | Skywalker

This is our table of names,
allowing a given person to have multiple names.
But what we *thought* we wanted was a person table
with one row for each person, like this:

sw_id | first_name | last_name
---|---|---
1 | Luke | Skywalker
2 | Leia | Organa
3 | Darth | Vader
4 | Han | Solo

In SQL we could assert that the "sw_id" column of the person table
is a PRIMARY KEY.
This means it must be unique.
(It probably shouldn't be NULL either!)

The names in the person table could be the primary names
that we use in our *Star Wars* database system,
and we could have another alternative_name table:

sw_id | first_name | last_name
---|---|---
3 | Anakin | Skywalker

## Holes

Tables are great!
We can add more columns to our person table:

sw_id | first_name | last_name | occupation
---|---|---|---
1 | Luke | Skywalker | Jedi
2 | Leia | Organa | princess
3 | Darth | Vader |
4 | Han | Solo | scoundrel

The 2D pattern of a table is a strong one.
It not only provides a "slot" (cell)
for every combination of row and column,
it also makes it very obvious when one of those slots is *empty*.
What does it mean for a slot to be empty?
It could mean many things.

For example, in the previous table
in the row for Darth Vader,
the cell for the "occupation" column is empty.
This could mean that:

- we don't know whether he has an occupation
- we know that he has an occupation, but we don't know which occupation it is.
- we might know, but we haven't bothered to write it down yet
- we might know, but it doesn't fit nicely
  into the New Republic Standard Registry of Occupations;
  in other words, we know what his occupation is,
  but including it here would violate a constraint on our database
- we specifically know that he doesn't have an occupation;
  we triple-checked
- we know more generally (**Spoiler Alert!!**) that he's dead,
  and dead people can't have an occupation.

I'm sure I haven't captured all the possibilities.
The point is that there's lot of possible reasons
why a cell would be blank.
So what can we do about it?

If our table is stored in a SQL database,
then we have the option of putting a NULL value in the cell.
NULL is pretty strange.
It isn't TRUE and it isn't FALSE.
Usually NULL values are excluded from SQL query results
unless you are careful to ask for them.

The way that NULL works in SQL eliminates some of the possibilities above.
SQL uses the "closed-world assumption",
which is the assumption that if a statement is true then it's known to be true,
and conversely that if it's not known to be true then it's false.
So if Anakin's occupation is NULL in a SQL database,
then as far as SQL is concerned,
we must know that he doesn't have an occupation.
That might not be what you were expecting!

The Software Carpentry module on
[Missing Data](http://swcarpentry.github.io/sql-novice-survey/05-null/index.html)
has more information.

## Multiple Values

Tables are great!
Let's add even more information to our table:

sw_id | first_name | last_name | occupation | enemy
---|---|---|---|---
1 | Luke | Skywalker | Jedi | 3
2 | Leia | Organa | princess | 3
3 | Darth | Vader | | 1,2,4
4 | Han | Solo | scoundrel | 3

We're trying to say that Darth Vader is the enemy of everybody else in our table.
We're using the primary key of the person in the enemy column, which is good,
but we've ended up with multiple values in the "enemy" column
for Darth Vader.

In any table or SQL database you could
make the "enemy" column a string,
pick a delimiter such as the comma,
and concatenate your values into a comma-separated list.
This works, but not very well.

In some SQL databases, such as Postgres,
you could given the "enemy" column an array type,
so it can contain multiple values.
You get special operators for querying inside arrays.
This can work pretty well.

The usual advice is to break this "one to many" information
into a new "enemy" table:

sw_id | enemy
---|---
1 | 3
2 | 3
3 | 1
3 | 2
3 | 4
4 | 1

Then you can JOIN the person table to the enemy table as needed.

## Sparse Tables

Tables are great!
Let's add even more information to our table:

sw_id | first_name | last_name | occupation | father | lightsaber_color | ship
---|---|---|---|---|---|---
1 | Luke | Skywalker | Jedi | 3 | green |
2 | Leia | Organa | princess | 3 | |
3 | Darth | Vader | | | red |
4 | Han | Solo | scoundrel | | | Millennium Falcon

A bunch of these columns only apply to a few rows.
Now we've got a lot more NULLs to deal with.
As the number of columns increases,
this can become a problem.

## Property Tables

Tables are great!
If sparse tables are a problem,
then let's try to apply the same solution
that worked for the "many to one" problem in the previous section.

name table:

sw_id | first_name | last_name
---|---|---
1 | Luke | Skywalker
2 | Leia | Organa
3 | Darth | Vader
4 | Han | Solo
3 | Anakin | Skywalker

occupation table:

sw_id | occupation
---|---
1 | Jedi
2 | princess
4 | scoundrel

enemy table:

sw_id | enemy
---|---
1 | 3
2 | 3
3 | 1
3 | 2
3 | 4
4 | 1

father table:

sw_id | father
---|---
1 | 3
2 | 3

lightsaber_color table:

sw_id | father
---|---
1 | green
3 | red

ship table:

sw_id | ship
---|---
4 | Millennium Falcon

Hmm.
Yeah, that will work.
But every query we write will need some JOINs.
It feels like we've lost something.

## Entity, Attribute, Value

Tables are great!
But there's such a thing as *too many* tables.
We started out with a table
with a bunch of rows and a bunch of columns,
and ended up with a bunch of tables
with a bunch of rows but just a few columns.

I have a brilliant idea!
Let's combine all these property tables into just one table,
by adding a "property" column!

sw_id | property | value
---|---|---
1 | first_name | Luke
2 | first_name | Leia
3 | first_name | Darth
4 | first_name | Han
5 | first_name | Anakin
1 | last_name | Skywalker
2 | last_name | Skywalker
3 | last_name | Vader
4 | last_name | Solo
5 | last_name | Skywalker
1 | occupation | Jedi
2 | occupation | princess
4 | occupation | scoundrel
1 | enemy | 3
2 | enemy | 3
3 | enemy | 1
3 | enemy | 2
3 | enemy | 4
4 | enemy | 1
1 | father | 3
2 | father | 3
1 | lightsaber_color | green
3 | lightsaber_color | red
4 | ship | Millenium Falcon

It turns out that I'm not the first one to think of this idea.
People call it "Entity, Attribute, Value" or "EAV".
People also call it an "anti-pattern",
in other words: a clear sign that you've made a terrible mistake.

There are lots of circumstances in which
one big, extremely generic table is a bad idea.
First of all, you can't do very much
with the datatypes for the property and value columns.
They kind of have to be strings.
It's potentially difficult to index.
And tables like this are miserable to query,
because you end up with all sorts of self-joins to handle.

But there's at least one use case where it turns out to work quite well...

## Merging Tables

Tables are great!
Until they're not.

The strong row and column structure of tables
makes them great for lots of things,
but not so great for merging data from different sources.
Before you can merge two tables
you need to know all about:

1. how the columns are structured
2. what the rows mean
3. what the cells mean

So you need to know the schemas of the two tables
before you can start merging them together.
But if you happen to have two EAV tables then,
as luck would have it,
they already have *the same* schema!

You also need to know that you're talking about the same things:
the rows have to be about the same things,
you need to be using the same property names for the same things,
and the cell values also need to line up.
If only there was an open standard for specifying globally unique identifiers...

Yes, you guessed it: URLs (and URNs and URIs and IRIs)!
Let's assume that we use the same URLs for the same things
across the two tables.
Since we're a close-knit community,
we've come to an agreement on a *Star Wars* data vocabulary.

URLs are annoyingly long to use in databases,
so let's use standard "sw" prefix to shorten them.
Now we have table 1:

sw_id | property | value
---|---|---
sw:1 | sw:first_name | Luke
sw:2 | sw:first_name | Leia
sw:3 | sw:first_name | Darth
sw:4 | sw:first_name | Han
sw:5 | sw:first_name | Anakin
sw:1 | sw:last_name | Skywalker
sw:2 | sw:last_name | Skywalker
sw:3 | sw:last_name | Vader
sw:4 | sw:last_name | Solo
sw:5 | sw:last_name | Skywalker
sw:1 | sw:occupation | sw:Jedi
sw:2 | sw:occupation | sw:princess
sw:4 | sw:occupation | sw:scoundrel

and table 2:

sw_id | property | value
---|---|---
sw:1 | sw:enemy | sw:3
sw:2 | sw:enemy | sw:3
sw:3 | sw:enemy | sw:1
sw:3 | sw:enemy | sw:2
sw:3 | sw:enemy | sw:4
sw:4 | sw:enemy | sw:1
sw:1 | sw:father | sw:3
sw:2 | sw:father | sw:3
sw:1 | sw:lightsaber_color | green
sw:3 | sw:lightsaber_color | red
sw:4 | sw:ship | Millenium Falcon

To merge these two tables, we simple concatenate them.
It couldn't be simpler.

Wait, this looks kinda familiar...

## RDF

These tables are pretty much in RDF format.
You just have to squint a little!

- sw_id == subject
- property == predicate
- value == object

Each row of the table is a subject-predicate-object triple.
Our subjects, predicates, and some objects are URLs.
We also have some literal objects.
We could turn this table directly into Turtle format
with a little SQL magic
(basically just concatenating strings):

```sql
SELECT "@prefix sw: <http://example.com/sw_> ."
UNION ALL
SELECT ""
UNION ALL
SELECT 
   subject
|| " "
|| predicate
|| " "
|| IF(
     INSTR(object, ":"),
     object,                -- CURIE
     """" || object || """" -- literal
   )
|| " ."
FROM triple_table;
```

The first few lines will look like this:

```ttl
@prefix sw: <http://example.com/sw_> .

sw:1 sw:first_name "Luke" .
sw:2 sw:first_name "Leia" .
sw:3 sw:first_name "Darth" .
sw:4 sw:first_name "Han" .
```

Two things we're missing from RDF are
language tagged literals and typed literals.
We also haven't used any blank nodes in our triple table.
These are easy enough to add.

The biggest thing that's different about RDF
is that it uses the "open-world assumption",
so something may be true even though
we don't have a triple asserting that it's true.
The open-world assumption is a better fit
than the closed-world assumption
when we're integrating data on the Web.

## Conclusion

Tables are great!
We use them all the time,
they're strong and rigid,
and we're comfortable with them.

RDF, on the other hand, looks strange at first.
For most common data processing,
RDF is *too* flexible.
But sometimes flexiblity is the most important thing.

The greatest strength of tables is their rigid structure,
but that's also their greatest weakness.
We saw a number of problems with tables,
and how they could be overcome
by breaking tables apart into smaller tables,
until we got down to the most basic pattern:
subject-predicate-object.
Step by step, we were pushed toward RDF.

Merging tables is particularly painful.
When working with data on the Web,
merging is one of the most common and important operations,
and so it makes sense to use RDF for these tasks.
If self-joins with SQL is the worst problem for EAV tables,
then SPARQL solves it.

These examples show that it's not really very hard
to convert tables to triples.
And once you've seen SPARQL, the RDF query language,
you've seen one good way to convert triples to tables:
SPARQL SELECT results are just tables!

Since it's straightforward to convert
tables to triples and back again,
make sure to use the right tool for the right job.
When you need to merge heterogeneous data, reach for triples.
For most other data processing tasks, use tables.
They're great!

