# LISP

A directory of resources I've collected and work I've done to teach myself LISP


## About

The books I've followed each have their own folder dedicated to them, in which are found PDFs of the books themselves as well as source code related to their contents. These books include:
- ANSI Common Lisp by Paul Graham


## Prerequisites and usage

In order to follow the books included in this repo, I used a regular old installation of `CLisp` on Ubuntu.

```shell
$ sudo apt install clisp
```

For each chapter I created a new file `c{N}.lsp`, and wrote down every line of code to run it and double check the output. I also did most of the exercises in a separate file `c{N}ex.lsp`.

In order to improve the output of these files, I created a file containing helper functions `headers.lsp`, which would print chaper/section/etc. headers. I also wrote the file `runner.lsp`, in order to see both the input and the output. The program takes any number of files of Lisp source code, and outputs each expression and the resulting output in a way to may it look like it was all typed in a REPL.

```shell
$ clisp runner.lsp c1.lsp c2.lsp c2ex.lsp
```

For easier viewing, it might be nice to pipe the output of the command above into `tail` while following the chapter. Or, for scrolling through the output of any number of chapters, use `less` instead.

```shell
$ clisp runner.lsp c3.lsp | tail -n 20
$ clisp runner.lsp c1.lsp c2.lsp c2ex.lsp | less
```

Example output:
```cl
$ clisp runner.lsp c3.lsp | head -n 30

> (LOAD headers.lsp)
/home/frode/Learning/lisp/ansicl/headers.lsp
> (CHAPTER 3 LISTS)

==================================================
    3 LISTS
==================================================
> (SECTION 3 1 Conses)

    3.1 Conses
--------------------------------------------------
> (SETF X (CONS 'A NIL))
(A)
> X
(A)
> (CAR X)
A
> (CDR X)
NIL
> (SETF Y (LIST 'A 'B 'C))
(A B C)
> (CDR Y)
(B C)
> (SETF Z (LIST 'A (LIST 'B 'C) 'D))
(A (B C) D)
> (CAR (CDR Z))
(B C)
> (CONSP (LIST 'A))
T
```


## Notes to self:

In order to indent an entire file of Lisp code automatically in Vim, do `gg=G`.


## Links:

Why Lisp is great:

- [Paul Graham's essays](http://www.paulgraham.com/articles.html)
- [The Lisp Curse](http://www.winestockwebdesign.com/Essays/Lisp_Curse.html)

Why Lisp fails:

- [The Language Squint Test](https://www.teamten.com/lawrence/writings/the_language_squint_test.html)

Learn Lisp:

- [Codementor - (learn '(LISP))](https://www.codementor.io/@skilbjo/learn-lisp-hba8gwngh)
- [What's the best way to learn LISP? - Stack Overflow](https://stackoverflow.com/questions/398579/whats-the-best-way-to-learn-lisp)
- [Practical Common Lisp](https://gigamonkeys.com/book/)
- [ClojureDocs - Community-Powered Clojure Documentation and Examples](https://clojuredocs.org/)
