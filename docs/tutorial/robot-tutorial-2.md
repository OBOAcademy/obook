# ROBOT Tutorial 2: Annotate, Merge, Reason and Diff

In week 6, we got some hands-on experience with ROBOT using `convert`, `extract`, and `template`. This week, we will learn four new ROBOT commands:
* [Annotate](http://robot.obolibrary.org/annotate)
* [Merge](http://robot.obolibrary.org/merge)
* [Reason](http://robot.obolibrary.org/reason)
* [Diff](http://robot.obolibrary.org/diff)

The goal of these and previous commands is to build up to creating an ontology release workflow.

Before starting this tutorial, either:
* make sure Docker is running and you are in the container
* [download and install ROBOT](http://robot.obolibrary.org/) for your operating system

To start, we will be working in the same folder as the first [ROBOT Mini-Tutorial](robot-tutorial-1.md). Navigate to this folder in your terminal and list the contents of the current directory by running `ls`. You should see `catalog-v001.xml` listed as one of these files. We want to delete this so that we can fix the ontology IRI problem we ran into last week! Before going any further with this tutorial, do this by running either `del catalog-v001.xml` for Windows or `rm catalog-v001.xml` if you're using Docker, MacOS, or other Linux system.

---

## Annotate

The `annotate` command allows you to attach metadata to your ontology in the form of IRIs and ontology annotations. Like the annotations on a term, ontology annotations help users to understand how they can use the ontology.

### Ontology IRIs

As we discussed during previous parts of the course, ontology IRIs are very important! We saw how importing an ontology without an IRI into another ontology without an IRI can cause some problems in the `catalog-v001.xml` file. We're going to fix that problem by giving IRIs to both our `animals.owl` and `animals2.owl` files.

Let's start with `animals.owl`:
```
robot annotate --input animals.owl \
  --ontology-iri http://example.com/animals.owl \
  --output animals.owl
```

You'll notice we gave the same file name as the input file; we're just updating our previous file so we don't need to do this in a separate OWL file.

On your own, give `animals2.owl` the ontology IRI `http://example.com/animals2.owl`. Remember that, in reality, we always want our ontology IRIs to be *resolvable*, so these would be pretty bad IRIs for an actual ontology.

Let's fix our import statement now. Open `animals2.owl` in Protégé and go to the **Entities** tab. You'll see that even though we still have the import statement in the **Active ontology** tab, the top-level terms are no longer labeled. Since we changed the ontology IRI, Protégé can no longer resolve our local file (because the `catalog-v001.xml` file was not updated). Go back to the **Active ontology** tab and click the X to the right of our original import. Then, re-add `animals.owl` as an import using the same steps as last time. When you return to the **Entities** tab, you'll once again see the labels of the top-level terms.

### Version IRIs

When we release our ontologies, we want to make sure to include a version IRI. Like the ontology IRI, this should always resolve to the version of the ontology at the time of the release. For clarity, we usually use dates in our version IRIs in the OBO Foundry. That way, you know when you navigate to a specific version IRI, that's what the ontology looked like on that date. (Note: edit files don't usually have version IRIs as they are always changing, and we don't expect to be able to point to a stable version)

While you can add a version IRI in Protégé, if you're trying to create an automated release workflow, this is a manual step you don't want to have to include. Keeping it in your release workflow also makes sure that the verion IRIs are consistent (we'll see how to do this with `make` later). For now, let's add a version IRI to `animals.owl` (feel free to replace the `2021-05-20` with today's date):

```
robot annotate --input animals.owl \
  --version-iri http://example.com/animals/2021-05-20/animals.owl \
  --output animals.owl
```

Let's break down this version IRI. We have the host (`http://example.com/`) followed by our ontology's namespace (`animals`). Next, we provided the date in the format of `YYYY-MM-DD`. Finally, we have the name of the file. This is standard for OBO Foundry, except with a different host. For example, you can find a release of OBI from April 6, 2021 at `http://purl.obolibrary.org/obo/obi/2021-04-06/obi.owl`. In this case, the host is `http://purl.obolibrary.org/obo/`. Of course, you may see different patterns in non-OBO-Foundry ontologies, but they should always resolve (hopefully!).

Go ahead and open or reload `animals.owl` in Protege. You'll see in the **Active Ontology** tab that now both the ontology IRI and version IRI fields are filled out.

### Ontology Annotations

In addition to ontology and version IRIs, you may also want to add some other metadata to your ontology. For example, when we were introduced to `report`, we added a description to the ontology to fix one of the report problems. The three ontology annotations that are required by the OBO Foundry are:
* Title (`dc11:title`)
* License (`dc:license`)
* Description (`dc11:description`)

These three annotation properties all come from the [Dublin Core](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/), but they have slightly different namespaces. This is because DC is split into two parts: the `/terms/` and `/elements/1.1/` namespaces. Just remember to double check that you're using the correct namespace. If you click on the DC link, you can find the complete list of DC terms in their respective namespaces.

ROBOT contains some built-in prefixes, which can be found [here](https://github.com/ontodev/robot/blob/master/robot-core/src/main/resources/obo_context.jsonld). The prefix `dc:` corresponds to the `/terms/` namespace and `dc11:` to `/elements/1.1/`. You may see different prefixes used (for example, `/terms/` is sometimes `dcterms:` or just `terms:`), but the full namespace is what really matters as long as the prefix is defined somewhere.

Let's go ahead and add a title and description to our `animals.owl` file. We'll do this using the `--annotation` option, which expects two arguments: (1) the CURIE of the annotation property, (2) the value of the annotation. The value of the annotation must be enclosed in double quotes if there are spaces. You can use any annotation property you want here, and include as many as you want! For now, we'll start with two:

```
robot annotate --input animals.owl \
  --annotation dc11:title "Animal Ontology" \
  --annotation dc11:description "An ontology about animals" \
  --output animals.owl 
```

`--annotation` adds these as strings, but remember that an annotation can also point to an link or IRI. We want our license to be a link, so we'll use `--link-annotation` instead to add that:

```
robot annotate --input animals.owl \
  --link-annotation dc:license https://creativecommons.org/licenses/by/4.0/ \
  --output animals.owl
```

OBO Foundry recommends using [Creative Commons](https://creativecommons.org) for all licenses. We just gave our ontology the most permissive of these, [CC-BY](https://creativecommons.org/licenses/by/4.0/).

When you open `animals.owl` in Protégé again, you'll see these annotations added to the **Active ontology** tab. You can also click on the CC-BY link!

---

## Merge

We've already learned how to include external ontologies as imports. Usually, for the released version of an ontology, the imports are *merged in* so that all contents are in one file.

Another reason you may want to merge two ontologies is if you're adding new terms to an ontology using `template`, like how we created new animal terms in `animals2.tsv` last time. We're going to demonstrate two methods of merging now. The first involves merging two (or more!) separate files and the second involves merging all imports into the current input ontology.

### Merging Multiple Files

First, copy `animals2.owl` to `animals-new.owl`. In Windows, this command is `copy animals2.owl animals-new.owl`. For Docker and other Linux operating systems, this is `cp animals2.owl animals-new.owl`. Open `animals-new.owl` in Protégé and remove the import we added last time. This is done in the **Imported ontologies** section of the **Active ontology** tab. Just click the X on the right side of the imported animals ontology. Don't forget to save!

Continuing with the `animals.owl` file we created last week, now run the following command:

```
robot merge --input animals.owl --input animals-new.owl --output animals-full.owl
```

When you just import an external ontology into your ontology, you'll notice in the Protégé class hierarchy that all terms from the external ontology are a less-bold text than internal terms. This can be seen when you open `animals2.owl`, where we imported `animals.owl`. This is simply Protégé's way of telling us that these terms are not part of *your current ontology*. Now that we've merged these two ontologies together, when you open `animals-full.owl` in Protégé, you'll see that *all* the terms are bold.

By default, the output ontology will get the ontology IRI of the first input ontology. We picked `animals.owl` as our first ontology here because this is the ontology that we're adding terms to, so we want our new output ontology to replace the original while keeping the same IRI. `merge` will also copy over all the ontology annotations from `animals.owl` (the first input) into the new file. The annotations from `animals2.owl` are ignored, but we'll talk more about this in our class session.

If we were editing an ontology in the wild, we'd probably now replace the original with this new file using `cp` or `copy`. For now, don't replace `animals.owl` because we'll need it for this next part.

*IMPORTANT*: Be very careful to check that the format is the same if you're replacing a file! Remember, you can always output OWL Functional syntax or another syntax by ending your output with `.ofn`, for example: `--output animals-full.ofn`.

### Merging Imports

When we want to merge all our imports into our working ontology, we call this *collapsing the import closure*. Luckily (since we're lazy), you don't need to type out each of your imports as an input to do this.

We already have `animals.owl` imported into `animals2.owl`. Let's collapse the import closure:

```
robot merge --input animals2.owl --collapse-import-closure true --output animals-full-2.owl
```

Even though we gave this a different file name, if you open `animals-full-2.owl` in Protégé, you'll notice that it's exactly the same as `animals-full.owl`! This is because we merged the same files together, just in a slightly different way. This time, though, the ontology IRI is the one for `animals2.owl`, not `animals.owl`. That is because that was our first input file.

---

## Reason

As we saw in the prepwork for Week 5, running a reasoner in Protégé creates an inferred class hierarchy. In the OBO Foundry, releases versions of ontologies usually have this inferred hierarchy *asserted*, so you see the full inferred hierarchy when you open the ontology without running the reasoner. ROBOT `reason` allows us to output a version of the ontology with these inferences asserted.

As we discussed, ELK and HermiT are the two main reasoners you'll be using. Instead of using our example ontologies (the asserted and inferred hierarchies for these will look exactly the same), we're going to use another ontology from the **Ontologies 101** tutorial from week 5. Navigate back to that directory and then navigate to `BDK14_exercises/basic-classification`.

Like running the reasoner in Protégé, running `reason` does three things:
1. Check for inconsistency
2. Check for unsatisfiable classes
3. Assert the inferred class hierarchy

Remember, when we run the reasoner in Protégé, if the ontology is inconsistent, `reason` will fail. If there are unsatisfiable classes, these will be asserted as `owl:Nothing`. ROBOT will always fail in both cases, but has some tools to help us figure out why. Let's introduce an unsatifiable class into our test and see what happens.

First, let's make a copy of `ubiq-ligase-complex.owl` and call this new file `unreasoned.owl` (`copy` or `cp`).

Open `unreasoned.owl` in Protégé and follow the steps below. These are things we've covered in past exercises, but if you get stuck, please don't hesitate to reach out.

1. Find 'organelle' in the class hierarchy below 'cellular_component' (or just search for it by label)
2. Make 'organelle' disjoint with 'organelle part' (either use the class hierarchy or type it in the expression editor)
3. Find 'intracellular organelle part' below 'intracellular part' or 'organelle part' (or search for it by label)
4. Add 'organelle' as a parent class to 'intracellular organelle part' (remember that you only need to include the single quotes if the label has spaces)

Like we did in the [Disjointness](https://ontology101tutorial.readthedocs.io/en/latest/Disjointness.html) part of the Ontologies 101 tutorial, we've made 'intracellular organelle part' a subclass of two classes that should have no overlap based on the disjointness axiom. Save the ontology and return to your terminal. Now, we'll run `reason`. The default reasoner is ELK, but you can specify the reasoner you want to use with the `--reasoner` option. For now, we'll just use ELK.

```
robot reason --input unreasoned.owl --output unsatisfiable.owl
```

You'll notice that ROBOT printed an error message telling us that the term with the IRI `http://purl.obolibrary.org/obo/GO_0044446` is unsatisfiable and ROBOT didn't create `unsatisfiable.owl`. This is ideal for automated pipelines where we don't want to be releasing unsatisfiable classes.

We can still use ROBOT to investigate the issue, though. It already gave us the IRI, but we can get more details using the `--dump-unsatisfiable` option. We won't provide an output this time because we know it won't succeed.

```
robot reason --input unreasoned.owl --dump-unsatisfiable unsatisfiable.owl
```

You can open `unsatisfiable.owl` in Protégé and see that 'intracellular organelle part' is not the only term included, even though it was the only unsatisfiable class. Like with the SLME method of extraction, all the terms used in unsatisfiable class or classes logic are included in this unsatisfiable module. We can then use Protégé to dig a little deeper in this small module. This is especially useful when working with large ontologies and/or the HermiT reasoner, which both can take quite some time. By extracting a smaller module, we can run the reasoner again in Protégé to get detailed explanations. In this case, we already know the problem, so we don't need to investigate any more.

Now let's reason over the original `ubiq-ligase-complex.owl` and see what happens:

```
robot reason --input ubiq-ligase-complex.owl --output reasoned.owl
```

If you just open `reasoned.owl` in Protégé, you won't really notice a different between this and the input file unless you do some digging. This takes us to our next command...

---

## Diff

The `diff` command can be used to compare the axioms in two ontologies to see what has been added and what has been removed. While the diffs on GitHub are useful for seeing what changed, it can be really tough for a human to read the raw OWL formats. Using ROBOT, we can output these diffs in a few different formats (using the `--format` option):
- `plain`: plain text with just the added and removed axioms listed in OWL functional syntax (still tough for a human to read, but could be good for passing to other scripts)
- `pretty`: similar to `plain`, but the IRIs are replaced with CURIEs and labels where available (still hard to read)
- `html`: a nice, sharable HTML file with the diffs sorted by term
- `markdown`: like the HTML diff, but in markdown for easy sharing on platforms like GitHub (perfect for pull requests!)

We're going to generate an HTML diff of `ubiq-ligase-complex.owl` compared to the new `reasoned.owl` file to see what inferences have been asserted. `diff` takes a left ("original") and a right ("new") input to compare.

```
robot diff --left ubiq-ligase-complex.owl \
  --right reasoned.owl \
  --format html \
  --output diff.html
```

Open `diff.html` in your browser side-by-side with `reasoned.owl` and you can see how the changes look in both.

*Homework question*: Running `reason` should assert inferences, yet there are some removed axioms in our diff. Why do you think these axioms were removed?
