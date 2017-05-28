# Maps

## Maps

Maps (not to be confused with the `Enum.map` function) are a very common programming construct, although they might be called "hashes" or "dictionaries" in other languages (or even, confusingly, "objects" in Javascript).

Here's a basic map:

```elixir
defmodule LearningElixir do
  def my_map do
    %{
      "name" => "Enterprise",
      "type" => "CodeShip",
      "mission" => "Code Boldly"
    }
  end
end
```

It's started with a `%{`, ended with a `}`, and in between consists of key-value pairs separated by commas.  Each key-value pair has a key (such as "name") before the `=>` symbol (sometimes called the "rocket") and a value (such as "Enterprise") after the `=>` symbol.

We can interact with this map using the functions in the `Map` module.

```elixir
iex(1)> Map.get(LearningElixir.my_map, "mission")
"Code Boldly"
iex(2)> Map.get(LearningElixir.my_map, "bad_key")
nil
```

Our first (and most common) Map function, `Map.get`, takes two arguments: the map (`LearningElixir.my_map`) and a key ("mission").  It will then grab the value attached to that key in the map.  If the key given doesn't exist in the hash, it will return `nil`.

You can use brackets as shorthand for `Map.get`.

```elixir
iex(1)> LearningElixir.my_map["mission"]
"Code Boldly"
```

The next most common Map function is to add new values to the map with `put`.

```elixir
iex(1)> Map.put(LearningElixir.my_map, "captain", "Picard")
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "type" => "CodeShip"}
iex(2)> LearningElixir.my_map
%{"mission" => "Code Boldly", "name" => "Enterprise", "type" => "CodeShip"}
```

When we use `put`, it uses the second and third arguments as the key and value respectively, and adds them to the map.  The result is seen after the first line.  However, you'll notice that when we call `LearningElixir.my_map` again, the new key-value isn't there.

## Immutability

That's because data in Elixir is "immutable".  That means that each piece of data will never change.  What `put` does is create a *new* piece of data and then assigns it to a variable.

To understand what "immutable" means, we'll have to contrast it with data in a mutable language.  Here's some javascript:

```javascript
> var mutableArray = ["Don't", "try", "this", "at", "home"];
undefined
> mutableArray.shift()
"Don't"
> mutableArray
["try", "this", "at", "home"]
```

Above, we're assigning 5 strings to the variable `mutableArray`.  Then we call the `shift` method on the `mutableArray`, which returns the first value in the array and has the *side effect* of removing that string from the array.  The array now only has 4 elements.

Contrast that with immutable data, where there will never be side effects- no matter what you call on an array with 5 items, it will always be an array with 5 items.

Of course, the return value of the function can be something other than 5 items.

```elixir
iex(1)> immutableArray = ["Immutability", "is", "great", "don't", "you", "agree"]
["Immutability", "is", "great", "don't", "you", "agree"]
iex(2)> Enum.slice(immutableArray, 4, 2)
["you", "agree"]
iex(3)> immutableArray
["Immutability", "is", "great", "don't", "you", "agree"]
```

So even though you call `Enum.slice` with `immutableArray` and get back an array with 2 items, `immutableArray` is still what it started as.  There are no side effects.

Of course, there's a trick you can play with the data- take the result of the calculation an *immediately reassign it* to the variable you used.

```elixir
iex(1)> immutableArray = ["Immutability", "is", "great", "don't", "you", "agree"]
["Immutability", "is", "great", "don't", "you", "agree"]
iex(2)> immutableArray = Enum.slice(immutableArray, 4, 2)
["you", "agree"]
iex(3)> immutableArray
["you", "agree"]
```

Oh no!  Even naming it `immutableArray` didn't stop that disaster!  How is this immutable data?

The array that `immutableArray` originally pointed to is still 5 items long.  It's just that we told `immutableArray` to point to a new, different array- one that was the result of calling `Enum.slice` on the original `immutableArray`.

Imagine if you could start calling yourself Germany and then the entire country of Germany could not longer be found.  Germany would still exist- you didn't mutate it- but everyone that was looking for Germany found you instead.

That's what it's like reassigning a variable.

One way around this is to keep on assigning stuff to new variables:

```elixir
iex(1)> phrase = "boldly going where no man has gone before"
"boldly going where no man has gone before"
iex(2)> phrase2 = String.split(phrase, " ")
["boldly", "going", "where", "no", "man", "has", "gone", "before"]
iex(3)> phrase3 = Enum.join(phrase2, "... ")
"boldly... going... where... no... man... has... gone... before"
iex(4)> phrase
"boldly going where no man has gone before"
iex(5)> phrase3
"boldly... going... where... no... man... has... gone... before"
```

That method, however, can get tedious.  That's one reason why the pipe (`|>`) construct is so popular in Elixir- it allows you to pass on the output of a function and use it as the first argument in the next function call, without the bother of naming it

```elixir
iex(1)> phrase =
...(1)> "boldly going where no man has gone before" |>
...(1)> String.split(" ") |>
...(1)> Enum.join("... ")
"boldly... going... where... no... man... has... gone... before"
iex(2)> phrase
"boldly... going... where... no... man... has... gone... before"
```

Remember: in the command line we put the pipe at the end of the line, to let the Elixir interpreter know that we have more coming on the next line.

Now let's apply this to `Map.put`:

```elixir
iex(1)> my_map = LearningElixir.my_map |>
...(1)> Map.put("captain", "Picard") |>
...(1)> Map.put("spock replacement", "Data")
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "spock replacement" => "Data", "type" => "CodeShip"}
iex(2)> my_map
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "spock replacement" => "Data", "type" => "CodeShip"}
```

We were able to feed the results of each line into the first argument of `Map.put`, then assign the whole thing to `my_map` without intermediate steps or explicit reassigns.  This approach gives us a syntax as convenient as mutability, but with the stability and long-term simplicity of immutability.

## Exercises

What will be the results from running each of the following functions?

```elixir
def one do
  map = %{"hello" => "universe"}
  Map.put(map, "discarded", "data")
  map
end

def two do
  map = %{"hello" => "universe"}
  Map.put(map, "discarded?", "data")
end

def three do
  %{"hello" => "universe"}
  |> Map.put("exploration_style", "bold")
  |> Map.put("starship", "Enterprise")
end

def four do
  %{"hello" => "universe"}
  |> Map.put("exploration_style", "bold")
  |> Map.put("starship", "Enterprise")
  |> Map.get("hello")
end
```

Be sure to check your work by copying the functions into a file and then running them.

## Conclusion

In this chapter we introduced our most complex data-type to date: Maps.  We learned how to get data from a map, and then how to update the data on a map- through creating a new copy of the map with updated data, because data in Elixir is immutable.

In the next chapter we'll introduce two more data types- Atoms and Tuples.  They'll let us expand our range with pattern matching capabilities significantly, especially when combined with the `case` statement.
