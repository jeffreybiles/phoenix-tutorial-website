# Getting Started with Elixir

Elixir is an awesome language that is filled to the brim with exciting features.  In part 1 we're only going to cover the basics- enough to get started with Phoenix.  Then in subsequent parts of this book we'll add on more language constructs as needed.

## The Elixir Interpreter

In order to show off the language features, we'll want to jump down to something simpler than a full Phoenix app.  To do that, we're going to use the Elixir Interpreter from the command line.

Open it up by typing `iex` in your command line.

```bash
$ iex
```

Now you should see something like the following:

```zsh
$ iex
  Erlang/OTP 19 [erts-8.3] [source] [64-bit] [smp:8:8] [async-threads:10]
  [hipe] [kernel-poll:false] [dtrace]

  Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```

This is good!  That means it's working.

Now you can type Elixir code in and it'll run right there (after you hit the Enter key).

```bash
iex(1)> 2 + 3
        5
```

Boom.  Type in `2 + 3`, hit enter, and it shows the result `5` in the line below.

> Your interpreter will show the results all the way to the left, but I've indented the results in this book so input/output lines are easier to differentiate and so output is easier to match up with the input that produced it.

When we build our Phoenix app we'll spend the majority of our time interacting with it in other ways, but we'll always have the option to drop back to the interpreter and play around.

```bash
iex(1)> 2 + 3
        5
iex(2)> (2 + 3) * 3
        15
iex(3)> 2 + (3 * 3)
        11
iex(3)> numTacos = 3
        3
iex(4)> numBurritos = 3 * 5
        15
iex(5)> numTacos + numBurritos
        18
```

The above demonstrate numbers, basic math, order of operations with parentheses (this will apply to more than just math), and the assignment and use of variables.

---

> **Captain's Log: Command Line Interpreter**

> Our scientists have discovered how to access the Command Line Interpreter (iex) that this manuscript speaks of.  

> At first we thought that we had forever trapped out computers in the interpreter, but we eventually discovered that we could exit by hitting Ctrl + C twice in a row.  This is good for when you're done, or if you get the interpreter into a weird state you don't understand.

> Exiting and re-entering also solved another mystery- the numbers in the interpreter prompt.  A few more superstitious in our crew thought them at first some sort of sinister countdown, but they are simply the number of lines since the interpreter started.

---

## Interpreter Exercises

What is displayed when you type each of these into the command line interpreter?  After thinking about it, test your answer.

1. `2 * 10`
2. `(2 * 10) + 3`
3. `2 * (10 + 3)`
4. `numTacos = 2 + 3; pepperPerTaco = 3; numTacos * pepperPerTaco`

(If you can't guess what `;` does, just go ahead and play around with it. Playing and testing your hypotheses is cheap in the command line!)

## Strings

There are two types of Strings in Elixir.

```elixir
iex(1)> "hello universe"
        "hello universe"
iex(2)> 'hello universe'
        'hello universe'
```

For the purposes of this book we'll be using double-quoted strings (sometimes called Binaries).  Single-quoted strings (sometimes called Char Lists) are mostly used when interfacing with old Elixir libraries.

---

> **Technobabble: Binaries vs Char Lists**

> Single-quoted strings are Lists of Characters and double-quoted strings are UTF-8 encoded binaries represented by a series of graphemes.  Even though we think of both of them as "Strings", we use different sets of functions on each.

> For a fun demonstration of a quirk of Char Lists, try putting `[111, 111, 112, 115]` in the command line.

---

Here's some basic inline usages of strings

```bash
iex(1)> "hello" <> "universe"
        "hellouniverse"
iex(2)> "hello" <> " universe"
        "hello universe"
iex(3)> place = "universe"
        "universe"
iex(4)> "hello #{place}"
        "hello universe"
```

Aside from these inline usages, most action on strings happens via functions being applied to them.  Here's an example:

```bash
iex(5)> phrase = "hello vast universe"
        "hello vast universe"
iex(6)> String.split(phrase, " ")
        ["hello", "vast", "universe"]
iex(7)> upcase_phrase = String.upcase(phrase)
        "HELLO VAST UNIVERSE"
iex(8)> phrase <> " -> " <> upcase_phrase
        "hello vast universe -> HELLO VAST UNIVERSE"
```

The string usage above is simple but allows us to demonstrate many facets of how Elixir works.

First, you'll notice that when we call `split` and `upcase`, we're not changing the original phrase.  Instead, we're creating a new copy of the phrase, which can be assigned to a variable (such as `upcase_phrase`).  The original string is "immutable"- that is, it cannot be changed (although a new immutable value could be assigned to the variable `phrase`).

Second, you'll notice that instead of calling a function which is stored on the string itself (`phrase.split(" ")`) we take our function and apply it to the string (`String.split(phrase, " ")`).  This may seem like a trivial difference, but in fact it is vital to understanding the functional nature of Elixir.

## Functional vs. Object-Oriented

In an object-oriented language the phrase would be an instance of the class String, and would therefore have available to it all the String functions.  Hence you could call `phrase.split(" ")`.

In a functional language, the phrase is the data, which can be acted upon by functions.  These functions are organized, so the most common functions which can act upon strings are stored in the `String` module, but what's important is we're separating out the data from the function instead of throwing them all in one "object".

If this doesn't make sense to you, that's okay- just move on.  We'll cover modules in the next chapter (and make our own), and the functional style of coding will become clearer to you as you write more Elixir.

## String exercises

What is displayed when you type each of these into the command line?  After thinking about it, test your answer.

1. `String.split("hello amazing universe", " ")`
2. `String.split("hello amazing universe", "i")`
3. `setting = "stun"; "set phasers to #{setting}"`

## Enum

The `Enum` module is meant for working with Enumerables.  Although there are others, the most common type of Enumerable is a list, so that's what we'll be working with today.

```bash
iex(1)> split_phrase = ["hello", "vast", "universe"]
        ["hello", "vast", "universe"]
iex(2)> Enum.count split_phrase
        3
iex(3)> Enum.join split_phrase, "-"
        "hello-vast-universe"
iex(4)> Enum.member? split_phrase, "universe"
        true
iex(4)> Enum.member? split_phrase, "univers"
        false
```

Once again we have our functions which are organized by module (`Enum`), which are then applied to the data (`split_phrase`).

We're also demonstrating a parentheses-free function syntax.  It's equivalent to having parentheses, except it's a bit cleaner (but, in some cases, more ambiguous.  In those cases parentheses should be added back).

## Char Lists vs Binaries

As an aside, remember how we have single-quoted strings (arrays of Chars) and double-quoted strings (binaries)?  Those types end up being important.  We use `Enum` functions on single-quoted Strings, and `String` functions on double-quoted Strings.

```bash
iex(1)> Enum.count 'hello'
        5
iex(2)> Enum.count "hello"
        ** (Protocol.UndefinedError) protocol Enumerable not implemented for "hello"
            (elixir) lib/enum.ex:1: Enumerable.impl_for!/1
            (elixir) lib/enum.ex:146: Enumerable.count/1
            (elixir) lib/enum.ex:467: Enum.count/1
iex(3)> String.split 'hello universe'
        ** (ArgumentError) argument error
            (stdlib) :binary.split('hello universe',
            ["　", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
            " ", <<194, 133>>, " ", "\t", "\n", "\v", "\f", "\r"], [:global])
            (elixir) unicode/unicode.ex:506: String.Break.split/1
iex(4)> String.split "hello universe"
        ["hello", "universe"]
```

> Want to see something cool?  Press 'tab' in iex to trigger an autocomplete.  So you type in "Stri", hit 'tab', and it'll complete it to "String".

> Even better, if there are multiple options, it will show you all of them that match your search.  Try hitting tab after typing in "String." (make sure to include the dat)- it'll show you all of the functions available on that module.

## Enum Exercises

What is displayed when you type each of these into the command line?  After thinking about it, test your answer.

1. `Enum.member?(["hello", "vast", "universe"], "hello")`
2. `Enum.member?(["hello", "vast", "universe"], "hello vast universe")`
3. `Enum.join(["hello", "vast", "universe"], "! ")`
4. `Enum.join(["hello", "vast", "universe"], "joining with this string is a very bad idea")`


## Chaining functions together

Let's say we wanted to count how many words are in a certain phrase.  We don't have a "word count" function, but we can get there by applying multiple functions in a row.  

There are several ways we could do this.  Here's the first.

```bash
iex(1)> phrase = "boldly going where no man has gone before"
        "boldly going where no man has gone before"
iex(2)> split_phrase = String.split(phrase)
        ["boldly", "going", "where", "no", "man", "has", "gone", "before"]
iex(3)> count = Enum.count split_phrase
        8
```

If you're unsure of where you're going and what to check at every step, that's probably the best way to go.  However, for production code it can look a bit messy.  Here's another way that's a bit more compact:

```bash
iex(1)> Enum.count(String.split("boldly going where no man has gone before"))
        8
```

Here we're nesting the function calls so the result of one gets fed into the other.  This is more compact, but it can still look messy.

A great solution to this is the pipe syntax.

## The Pipe Syntax

In the pipe syntax, we can take the results of one function and "pipe" it as the first argument of the next function.

```bash
iex(1)> "boldly going where no man has gone before" |> String.split |> Enum.count
        8
```

It's a couple more characters than the previous one, but it's far more readable.  You have the subject first (the phrase), and then you pass that phrase to `String.split`, then pass the results of that to `Enum.count`.

If you have multiple arguments, you just pass the second (and third and fourth, etc.) arguments with the function.

```bash
iex(1)> "boldly going where no man has gone before" |> String.split |> Enum.join("-")
        "boldly-going-where-no-man-has-gone-before"
```

When you're piping functions, be sure to use parentheses for your arguments- the compiler can usually infer them, but the pipe syntax makes that more difficult and so it's best to be explicit.

Working with pipes is a core part of the Elixir experience, and so most functions you encounter will be designed with piping in mind- they'll take *data* as their first argument, and then configuration for their other arguments.  You can see this with `Enum.join`, which takes in the list as the first argument and then `"-"` as the second argument.

## Pipe Exercises

What is displayed when you type each of these into the command line?  After thinking about it, test your answer.

1. `"boldly going where no man has gone before" |> String.length`
2. `"boldly going where no man has gone before" |> String.split(" ") |> Enum.member?("boldly")`
3. `"boldly going where no man has gone before" |> String.upcase |> String.split(" ") |> Enum.join("... ")`

## Conclusion

Already each individual line of Elixir should be looking less mysterious than before, but there's still plenty to learn.  In the next chapter we'll go over how to create and use custom functions.
