# Atoms, Tuples, and Case

In this chapter we'll cover three more basic Elixir concepts that are used often in Phoenix apps.  We'll also combine them (and build on the concepts we've previously learned) in order to discover even more ways of pattern matching.

## Atoms

Here's an example of an atom: `:name`.

Atoms are kind of like Strings, except that they can't be manipulated.  `"Name"` could be fed into `String.upcase |> String.slice(1, 3)`, which would output `"AME"`.  `:name` will always and forever be `:name`, unless it is first explicitly turned into a String. Hence the name: an atom is irreducible.

At first glance, Atoms could be dismissed as a less-capable replacement for Strings... but their power is in their limitations, both in the signaling value to humans (it will not be manipulated) and in the conveniences that it allows.

One popular use of atoms is as the key in a Map.  Here's what `my_map` from the last section would look like with a simple replacement:

```elixir
defmodule LearningElixir do
  def my_map do
    %{
      :name => "Enterprise",
      :type => "CodeShip",
      :mission => "Code Boldly"
    }
  end
end
```

Now when we want to access the code, we use an atom instead of a String:

```bash
iex(1)> LearningElixir.my_map[:name]
        "Enterprise"
iex(2)> LearningElixir.my_map["name"]
        nil
```

But here's the first convenience that atoms unlock:

```bash
iex(3)> LearningElixir.my_map.name
        "Enterprise"
```

This is much nicer than the clunky `["string"]` and `[:atom]` syntax.

You can also make your Map syntax nicer with atoms:

```elixir
defmodule LearningElixir do
  def my_map do
    %{
      name: "Enterprise",
      type: "CodeShip",
      mission: "Code Boldly"
    }
  end
end
```

That looks much cleaner than what we had before, and works the exact same way when being called as the `:name => "Enterprise"` syntax.

So we've got a bit of convenience and syntax nicety- why else would we use atoms?

The primary benefit of atoms comes in their signaling value.  A String can be manipulated- capitalized, split, reversed, etc. Elixir Strings are technically immutable (unchanging), but reassignment and piping make it easy for them to be manipulated without technically being mutated.  On the other hand, if an atom starts as `:name`, it will go through the entire system as `:name` (unless explicitly turned into a String and then turned back into an atom).

---

> **Captain's log: changing an Atom**

> I have noticed that these Atoms, though supposedly indivisible, can be turned into a String or a Char List.  This is, of course, a terrible idea, and should never be attempted.  Not even for a handy plot point!  Like the fourth wall, the integrity of atoms is very important to preserve.

---

Atoms are a perfect fit for keys in a Map construct.  They're also great for pattern matching.

## Pattern Matching with Atoms

```elixir
defmodule LearningElixir do
  def my_map do
    %{
      name: "Enterprise",
      type: "CodeShip",
      mission: "Code Boldly"
    }
  end

  def my_map(:voyager) do
    %{
      name: "Voyager",
      type: "Intrepid",
      mission: "Make it back"
    }
  end

  def my_map(:ds9) do
    %{
      name: "Terok Nor",
      type: "Station",
      mission: "Protect Bajor"
    }
  end
end
```

Now we're matching not just on arity (number of arguments), but also on the value of the argument given (for versions with arity of 1).

```bash
iex(1)> LearningElixir.my_map
        %{mission: "Code Boldly", name: "Enterprise", type: "CodeShip"}
iex(2)> LearningElixir.my_map(:ds9)
        %{mission: "Protect Bajor", name: "Terok Nor", type: "Station"}
```

Pattern matching is common with atoms, but it could be done with any datatype- Strings, numbers, even Maps.

One of the other common pattern-matching data-types is a Tuple.

## Tuples

Tuples are simply collections of values, surrounded by curly braces:

```bash
iex(1)> my_tuple = {"Babylon", 5}
        {"Babylon", 5}
```

As you can see, the values can be of any type- including multiple types within one tuple.  They can also be of any length, although lengths of 2 to 4 are most common.

You can access an element within a tuple using the `elem` function:

```bash
iex(2)> elem(my_tuple, 0)
        "Babylon"
```

As you can see, it's zero-indexed.

You can also decompose a tuple into its component parts:

```bash
iex(3)> {name, num} = my_tuple
        {"Babylon", 5}
iex(4)> name
        "Babylon"
```

This is a form of pattern matching, where the intent is to destructure the tuple into its component parts (sometimes this specific technique is just called "destructuring").

This is similar to the Map destructuring we covered briefly in the last chapter.  The biggest difference is that for a map you can destructure to as many or as few keys as a you like, but in a tuple you have to destructure to the whole tuple.  However, there are some conveniences-- if you don't need one part of it, you can just use the underscore symbol instead of coming up with a throwaway name:

```bash
iex(5)> {name, _} = my_tuple
        {"Babylon", 5}
iex(6)> name
        "Babylon"
```

We're essentially throwing away the number by using the underscore.  This saves us the trouble of naming it, and also communicates to future readers of our code which parts of the tuple will be used.

They can also be used to pattern match in function definitions:

```elixir
defmodule LearningElixir do
  def take_action({:ok, _}, ship) do
    "Great job, #{ship}"
  end

  def take_action({:error, error_message}, ship) do
    "Problem with #{ship}.  #{error_message}"
  end
end
```

Here both variations on the function have two arguments, the second of which is a ship and the first of which is a tuple.  The tuple has two values- an atom and a string.  The atom is either `:ok` or `:error`, and the string is used when the action is a failure but thrown away when the action is successful.

```bash
iex(1)> LearningElixir.take_action({:ok, "Make it so"}, "Enterprise")
        "Great job, Enterprise"
iex(2)> LearningElixir.take_action({:error, "Shields are at 38 percent!"}, "Enterprise")
        "Problem with Enterprise.  Shields are at 38 percent!"
```

Matching a tuple with an `:ok` or `:error` atom as the first value is very common in Phoenix apps.

## Conditionals with case

There are many other ways we could go about coding `take_action`.  Probably the most fitting is the `case` statement.

Here's a super simple example of a case statement:

```elixir
def rabbit_counting(number) do
  case number do
    0 -> "none"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    _ -> "many"
  end
end
```

A case statement has two parts- the expression and the clauses.  In this case statement, the expression is `number`, and there are six clauses.

Each clause has a head and a body.  The head (such as `1` or `_`) is before the arrow `->`, and is what matches against the expression.  The body is what's after the arrow `->`.  When a head matches, the body of that clause is returned.

So if you pass in `1`, you get `"one"` returned.  If you pass in `4`, you get `"four"` returned.  

What happens if you pass in `5`?  The underscore (`_`) in the head acts as a default, accepting anything.  So if we pass in `5`, it will be caught by the underscore and return `"many"`.  Be careful about that, though- if you put the underscore as the first clause, then it will catch *everything*, not letting any of the other more specific clauses match.

Now let's apply the case statement to our tuple pattern-matching example:

```elixir
defmodule LearningElixir do
  def take_action(tup, ship) do
    case tup do
      {:ok, _} -> "Great job, #{ship}"
      {:error, error_message} -> "Problem with #{ship}.  #{error_message}"
    end
  end
end
```

If `{:ok, _}` matches, then `"Great job, #{ship}"` will be returned, with `ship` being filled in with whatever was passed in to the function.

Case statements of this form are very common in Phoenix apps, so you'll have plenty of time to get used to how they work.

## Other Conditionals

There are two other common way of doing conditionals in Elixir: `cond` and `if`.  However, they aren't used nearly as often as `case` within Phoenix, so if we use them then we'll introduce them at that time.

This may be a bit of a shock to people from other languages who are used to using `if` for everything, but in Elixir `if` is used sparingly.  Most of the common usages of `if` can be done better by some sort of functional conditional- usually, but not always, involving pattern matching.

## Exercises

1. For the following code:

```elixir
{:ok, phaser_setting, _} = {:ok, "stun", "thank you"}
%{name: my_name} = %{rank: "Captain", name: "Picard"}
```

What is the value of `phaser_setting` and `my_name`?

> Hint: Rememmber the Map destructuring from the previous chapter

2. Type out our final version of the `take_action` function.  What happens when you call it as follows?  Why?

a. `LearningElixir.take_action({:err_bear, "Doctor, why is tummy glowing, is that cancer?"}, "Enterprise")`
b. `LearningElixir.take_action("no tuple here", "Enterprise")`
c. `LearningElixir.take_action({"ok", "I have made it so"}, "Enterprise")`
d. `LearningElixir.take_action({:ok, "I have made it so", "another part of the tuple, how fun"}, "Enterprise")`
e. `LearningElixir.take_action({:ok, "I have made it so"})`
f. `LearningElixir.take_action({:ok, "I have made it so"}, "Enterprise")`

Learning the common error modes is important- better that you do it now while your program is small.

3. Modify `take_action` so that the ship is passed as a third part of the tuple.

```bash
iex(1)> LearningElixir.take_action({:ok, "I have made it so", "Enterprise"})
        "Great job, Enterprise"
iex(2)> LearningElixir.take_action({:error, "Phasers not set to stun", "Enterprise"})
        "Problem with Enterprise.  Phasers not set to stun"
```

## Conclusion

Now, with the introduction of atoms, tuples, and condition statements, we're finally starting to see functions that might look at home in a Phoenix app.  In fact, our example for the case statement was inspired by the auto-generated Controller in Phoenix 1.2 and before (they're changing the generator in Phoenix 1.3, but it still depends on the concepts we've introduced in this chapter).

Great job- you've already learned quite bit!
