Command Line Trick to Filter Text Files
=======================================================
Let's say you want to remove some lines from a large text file programmatically. For example, you want to remove every line that contains certain IDs, but you want to keep the rest of the lines intact.
You can use the command line utility [`grep`](https://en.wikipedia.org/wiki/Grep) with option `-v` to find all the lines in the file that do NOT contain your search term(s). You can make a file with a list of several search terms and use that file with `grep` using the `-f` option as follows:

``` shell
grep -v -f your_list.txt target_file.tsv | tee out_file.tsv
```

### Explanation
- The target file is your text file from which you wish to remove lines. The text file can be of type `csv`, `tsv`, `obo` *etc.* For example, you wish to filter a file with these lines:

    keep this 1
    this line is	undesired 2, so you do not wish to keep it
    keep this 3
    keep this 4
    keep this 5
    keep this 6
    something	undesired 2
    this line is	undesired 1
    keep this 7

- The file `your_list.txt` is a text file with your list of search terms. Format: one search term per line. For example:

    undesired 1
    undesired 2

- The utility [`tee`](https://en.wikipedia.org/wiki/Tee_(command)) will redirect the standard output to both the terminal and write it out to a file.

- You expect the `out_file.tsv` to contain lines:

    keep this 1
    keep this 3
    keep this 4
    keep this 5
    keep this 6
    keep this 7


## Do the filtering and updating of your target file in one step
You can also do a one-step filter-update when you are confident that your filtering works as expected, or if you have a backup copy of your `target_file.tsv`.
Use [`cat`](https://en.wikipedia.org/wiki/Cat_(Unix)) and pipe the contents of your text file as the input for `grep`. Redirect the results to both your terminal and **overwrite your original** file so it will contain only the filtered lines.

``` shell
cat target_file.tsv | grep -v -f your_list.txt | tee target_file.tsv
```

