# Arguments and Pattern Matching

## Using Arguments

The `recombine` function is pretty cool, but it always uses the default phrase defined elsewhere in the module.  What if we wanted to allow the user the option of putting in their own phrase?

First we'll see how to *make* them input their own phrase:

```elixir
def recombine(phrase) do
  phrase
  |> String.split
  |> Enum.join("-")
end
```

This is the first function we've created that requires an argument, but we've used functions with arguments before.  When we call it we must feed it a phrase as input (with or without parentheses)

```exs
iex(1)> LearningElixir.recombine("hello world")
        "hello-world"
iex(2)> LearningElixir.recombine "hello world"
        "hello-world"
```

Next we'll figure out how to make the phrase argument *optional*.

There are several ways to do that.  The first solution we show, having a default value, will be typical of non-functional languages.  The second solution, which is modeled after a common Javascript pattern, will show us how different the two language's capabilities are and introduce us to the concept of Arity.  Finally, the third solution will take advantage of Elixir's functional abilities and give us our first taste of Pattern Matching.

## Default Value

```elixir
def recombine(phrase \\ LearningElixir.phrase) do
  phrase
  |> String.split
  |> Enum.join("-")
end
```

Here the argument has a *default value* of `LearningElixir.phrase`.  When defining an argument, you can put `\\` after an argument name and then give a default value- in this case, `LearningElixir.phrase`

```exs
iex(1)> LearningElixir.recombine
        "boldly-going-where-no-man-has-gone-before"
iex(2)> LearningElixir.recombine "hello universe"
        "hello-universe"
```

> Note: We skipped the `import_file "basic_elixir.ex"` line this time for brevity's sake, and we will continue to skip it, but you should keep calling `import_file` when you make changes.

This is a decent pattern for simple situations like what we have here, but is suboptimal once the complexity of your function starts to grow (specifically, the number and complexity of arguments passed to the function).

## Second Solution: Arity

Another way you could attempt to do this is to use the or (`||`) functionality.

```elixir
def recombine(phrase) do
  phrase = phrase || LearningElixir.phrase

  phrase
  |> String.split
  |> Enum.join("-")
end
```

In many languages, if you don't give a default value for an argument the default will automatically be `nil`.  However, this is not the case in Elixir.  Here's what happens if you try that:

```exs
iex(1)> LearningElixir.recombine()
        ** (UndefinedFunctionError) function LearningElixir.recombine/0
        is undefined or private.
        Did you mean one of:

              * recombine/1

            LearningElixir.recombine()
```

It's saying that `LearningElixir.recombine/0` is undefined or private... what does that mean?  Didn't we define `recombine`?  And what's that `0` afterwards?  The answer, as you may have guessed from this section header, is "arity".

"Arity" is a fancy word for the number of arguments a given function requires.  So we've defined LearningElixir.recombine/1 (a version of `recombine` with 1 argument), but not LearningElixir.recombine/0 (a version of `recombine` with 0 arguments).  This can be annoying when we're used to looser languages that default to `nil` automatically, but it's really helpful for when we accidentally forget an argument- Elixir will help us catch that bug right at the start.

We can, of course, "cheat" the arity system by providing default values:

```elixir
def recombine(phrase \\ nil) do
  phrase = phrase || LearningElixir.phrase

  phrase
  |> String.split
  |> Enum.join("-")
end
```

But the existence of the concept of arity, combined with Pattern Matching, opens up a better possibility.

## Pattern Matching

Pattern Matching is a way to define a function multiple times and then run a specific definition based on the arguments given.  One way to pattern match is by arity.

```elixir
def recombine(phrase) do
  phrase
  |> String.split
  |> Enum.join("-")
end

def recombine do
  LearningElixir.phrase |> LearningElixir.recombine
end
```

Here we're defining two versions of recombine- the first with an arity of 1 and the second with an arity of 0.  When we call it with an argument, we get the first version of `recombine`.  When we call it without an argument, we get the second version- which then calls the first version and feeds it the phrase we defined earlier.

```exs
iex(1)> LearningElixir.recombine "hello world, universe"
        "hello-world,-universe"
iex(2)> LearningElixir.recombine
        "boldly-going-where-no-man-has-gone-before"
```

Pretty cool, right?  There are lots of other ways you can employ pattern matching beyond simple number of arguments, and we'll go over those as they come up.

## Exercises

1.  Use pattern matching to add a 2-arity version of `recombine` which lets you input the join string.

```exs
iex(1)> LearningElixir.recombine("hello world, universe", " vast ")
        "hello vast world, vast universe"
iex(2)> LearningElixir.recombine("hello universe")
        "hello-universe"
```

2. Redefine the 1-arity version of `recombine` in terms of the 2-arity version.

That is, make it so that the 1-arity version calls the 2-arity version instead of repeating code.  You'll note that we already defined the 0-arity version to call the 1-arity version.

---

> **Captain's Log: Function Ordering**

> Our scientists have arranged the above functions of different arities in many orders, and have found no difference in how the program runs.

> However, in other situations the order does matter- Elixir will check the functions in order and use the first one that matches.  So we have made it a habit to put the more specific cases earlier in the file and the more general cases later in the file.

---

## Conclusion

Learning how to define functions with arguments (and using pattern matching to define multiple versions of a function) make our functions much more flexible and useful.

In the next chapter we'll introduce our first complex data type- Maps. Playing around with them will also lead us to the concept of Immutability- something very important in the functional programming world.
