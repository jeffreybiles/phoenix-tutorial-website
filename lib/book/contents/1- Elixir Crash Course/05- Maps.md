# Maps

## Maps

Maps (not to be confused with the `Enum.map` method) are a very common programming construct, although they might be called "hashes" or "dictionaries" in other languages (or even, confusingly, "objects" in Javascript).

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

We can interact with this map using the methods in the `Map` module.

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

That's because data in Elixir is "immutable".  That means that each piece of data will never change.

When it looks like it's changing, that's because it's creating a new piece of data and assigning it to a variable.  There can sometimes be an illusion of mutability since variables can be reassigned, but rest assured- the underlying data constructs are never changing.  This is one reason why the pipe (`|>`) construct is so popular in Elixir- it allows you to pass on the output of a function and use it as the first argument in the next function call, keeping the benefits of immutability but removing the overhead of assigning and reassigning variables.

Here's how we can use variables to keep around the results of the `put`:

```elixir
iex(1)> my_map = Map.put(LearningElixir.my_map, "captain", "Picard")
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "type" => "CodeShip"}
iex(2)> my_map = Map.put(my_map, "spock replacement", "Data")
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "spock replacement" => "Data", "type" => "CodeShip"}
iex(3)> Map.put(my_map, "for contrast", "this won't stick around")
%{"captain" => "Picard", "for contrast" => "this won't stick around",
  "mission" => "Code Boldly", "name" => "Enterprise",
  "spock replacement" => "Data", "type" => "CodeShip"}
iex(4)> my_map
%{"captain" => "Picard", "mission" => "Code Boldly", "name" => "Enterprise",
  "spock replacement" => "Data", "type" => "CodeShip"}
```

What we did above: on the first line, we put a key-value pair on the map in LearningElixir and then assigned our new Map to `my_map`.  Then on the second line we used `my_map`, put a new key-value pair on it, then reassigned it to `my_map`.  The third line used `my_map` but didn't reassign it.  Then on the fourth line, when we display `my_map`, we'll see that it kept both key-value pairs from when it assigned to `my_map`, but discarded the change that did not involve assigning to a variable.

Let's see how this looks using the pipe syntax:

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

Here we used the pipe in the same line as the previous command, instead of preceding the next command, so that we could let the interpreter know that we wanted to continue with the same statement.  That's how we get `...(1)` on the second and third lines.

More to the point, we were able to feed the results of each line into the first argument of `Map.put`, then assign the whole thing to `my_map` without intermediate steps or explicit reassigns.  This approach gives us a syntax as convenient as mutability, but with the stability and long-term simplicity of immutability.

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

Be sure to check your work by copying the methods into a file and then running them.

## Conclusion

In this chapter we introduced our most complex data-type to date: Maps.  We learned how to get data from a map, and then how to update the data on a map- through creating a new copy of the map with updated data, because data in Elixir is immutable.

In the next chapter we'll introduce two more data types- Atoms and Tuples.  They'll let us expand our range with pattern matching capabilities significantly, especially when combined with the `case` statement.
