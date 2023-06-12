# The logical building blocks of OWL
Here we briefly list the building blocks that are used in OWL that enable reasoning.

| OWL                    | Semantics          | Example                                    |
|------------------------|--------------------|--------------------------------------------|
| instance or individual | A member of a set. | A person called `Mary` or a dog called `Fido`. |
| class                  | A set of in dividuals. | The `Person` class consisting of persons or the `Dog` class consisting of dogs.|
| object property | A set of pairs of individuals. | The `owns` object property can link a pet and its `owner: Mary owns Fido`.|
| data property | A set of pairs where each pair consists of an individual linked to a data value.|The data property `hasAge` can link a number representing an age to an individual: `hasAge(Mary, 10)`.|
