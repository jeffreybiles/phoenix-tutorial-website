# Functions

So far in our exploration of Elixir we've typed our code directly into the Elixir interpreter, but for complex functions -- not to mention building an entire program -- we'll want a place to store our functions.

In this chapter we'll learn how to store our code by defining modules and functions.

## Storing Code: defmodule and def

Start by creating a file.  I'm going to call mine `basic_elixir.ex`, but the only part of this name that you are required to copy is the `.ex` file extension, which signals that this is an Elixir file.

Then we'll create the minimum viable module in this file:

```elixir
defmodule LearningElixir do
  def hello do
    "boldly going where no man has gone before"
  end
end
```

Our module, defined by `defmodule` (DEFine MODULE), is `LearningElixir`.  Attached to that we have a `do` and its closing `end`.  This pair of "delimiters" indicates that anything in between them is part of the `LearningElixir` module.  Some languages use whitespace or curly braces as their delimiters, but Elixir has copied Ruby and uses the more descriptive `do` and `end` keywords.

Our function `hello` is defined by `def`.  It also has a do/end delimiting block.  Inside that block is the string "boldly going where no man has gone before", which is what is returned when we call that function.

Let's go ahead and load that file in the Interpreter.

```zsh
iex(1)> import_file "basic_elixir.ex"
        {:module, LearningElixir,
         <<70, 79, 82, 49, 0, 0, 4, 52, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 134,
           0, 0, 0, 13, 21, 69, 108, 105, 120, 105, 114, 46, 76, 101, 97, 114, 110, 105,
           110, 103, 69, 108, 105, 120, 105, 114, 8, ...>>, {:hello, 0}}
iex(2)> LearningElixir.hello
        "boldly going where no man has gone before"
```

<!-- TODO: Check that all the numbers stuff is still happening -->

---

> **Captain's Log: Loading Elixir Files**

> It took much experimentation, but we have finally discovered how to load code into the ship's interpreter.

> Our error was that we were in the wrong folder- the computer didn't know how to find `basic_elixir.ex`.  Our solution: be in the same folder as the file when we start the Elixir interpreter.

> Our scientists have reported that we may be able to access the file from a different folder by specifying the path but, truth be told, I prefer the simple way.

---

We load the file into the Interpreter with the command `import_file`.  We can ignore the output for now; only notice that we see both `LearningElixir` and `hello` in various forms.

Then we call our function with `LearningElixir.hello` and get back the expected string.

> Note that we precede the function name with the name of the module within which it resides.  Apply the logic to our commands from the previous chapter and we can see that `String.split` was calling the `split` function on the `String` module.

Next let's define a new function, which has the code that we had previously inputted directly into the command line:

```elixir
defmodule LearningElixir do
  def phrase do
    "boldly going where no man has gone before"
  end

  def recombine do
    phrase |> String.split |> Enum.join("-")
  end
end
```

We've renamed `hello` to `phrase`, then used it in our `recombine` function.  Note that since we're within the `LearningElixir` module we don't need to precede `phrase` with `LearningElixir`- `phrase` is currently directly available because it's "within scope".

---

> **Captain's Log: Scope**

> Scope can be a scary word, but here's a basic way to think about it.  If you're in your ship's common room, and you say "I would like to sit on the couch", you don't have to specify which of the millions of couches you're sitting on.  You're in the common room scope, so when you're trying to think of couches, the one in the ship's common room comes to mind first.

> It's the same reason that if you talked to someone in the old United States about "the civil war", they'll immediately think of the American Civil War, not the Spanish Civil War, the American Revolution, or the Klingon Civil War.  That's because they're scoped to the United States.

> Scope isn't as big a deal in Elixir as it is in Object-Oriented languages, but it's still important to understand.

---

The rest of our `recombine` function is just like what we previously did directly in the interpreter.

Let's load and call this in the interpreter.

```zsh
iex(3)> import_file "basic_elixir.ex"
        warning: redefining module LearningElixir (current version defined in memory)
          iex:1

        warning: variable "phrase" does not exist and is being expanded to "phrase()",
        please use parentheses to remove the ambiguity or change the variable name
          iex:7

        {:module, LearningElixir,
         <<70, 79, 82, 49, 0, 0, 5, 40, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 182,
           0, 0, 0, 18, 21, 69, 108, 105, 120, 105, 114, 46, 76, 101, 97, 114, 110, 105,
           110, 103, 69, 108, 105, 120, 105, 114, 8, ...>>, {:recombine, 0}}
iex(4)> LearningElixir.recombine
        "boldly-going-where-no-man-has-gone-before"
```

The result of `LearningElixir.recombine` is what we would expect if we straightforwardly combined what we previously knew.

Less expected are the two warnings.  

The first warning is the result of importing the same file (and thus defining the same module) twice in one interpreter session.  If we had restarted the interpreter in between loading the file then this warning would not show up.  

The second warning is because `phrase` is somewhat ambiguous- it could be either a variable or a function.  The interpreter automatically (and correctly) expands it to `phrase()`, which is the less ambiguous way to call a function.

There are two ways to solve the ambiguity:

```elixir
defmodule LearningElixir do
  def phrase do
    "boldly going where no man has gone before"
  end

  def recombine1 do
    phrase() |> String.split |> Enum.join("-")
  end

  def recombine2 do
    LearningElixir.phrase |> String.split |> Enum.join("-")
  end
end
```

The first is exactly what's suggested by the warning: add in the parentheses.  The second makes explicit the fact that `phrase` is defined on the `LearningElixir` module, thus removing the ambiguity.  I personally prefer the second solution (it makes the function more portable because you don't have to worry about scope), but either works.

Finally, now that we're in a proper file we don't have to define everything on one line.

```elixir
defmodule LearningElixir do
  def phrase do
    "boldly going where no man has gone before"
  end

  def recombine do
    LearningElixir.phrase
    |> String.split
    |> Enum.join("-")
  end
end
```

This version of `recombine` does exactly the same as our last version, but now instead of having everything in one line we have the pipes lined up vertically.  This can be very convenient for seeing at a glance how a function is composed.

## Exercises

1. Create the `LearningElixir` module, with the `phrase` and `recombine` functions in it.  Import it on the command line, then run `LearningElixir.recombine`.
2. Within that module, create the `upcase_phrase` function, which returns the phrase, but all in upper case letters.  Use the `phrase` function in your solution- you're cheating if you just type out the phrase manually in upper case.

```bash
> iex(1)> LearningElixir.upcase_phrase
          "BOLDLY GOING WHERE NO MAN HAS GONE BEFORE"
```

We introduced the relevant `String` function in the last chapter.

## Conclusion

Now you know how to create a module that organizes your functions.  This increases your ability to organize your code aesthetically (lining up pipe operators) and opens up many new possibilities.  However, our current understanding is still very limited.

In the next chapter, we'll show how to create more flexible functions by giving them arguments- and by introducing our first instance of Pattern Matching, the functional programming design pattern that you'll soon grow to love.
