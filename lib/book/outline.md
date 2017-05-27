* Install elixir
* Just Enough elixir
* Install Phoenix, generate app
* Github setup
* Deploy
* Play with Info page (introduce html, routing, controller, link_to, params)
* Generate Material, start of whirlwind tour
  * Generate `mix phoenix.gen.html Material materials name:string amount:decimal latinum_per_1k:decimal`
  * Everything you can do with generated resource
  * Put in some resources
* Materials Index
  * `resources`, REST
  * migration and schema (skim over changeset, but don't go into detail yet)
  * controller- index
  * template- index
  * route and X_path?
* Materials Show
  * controller- show
  * template- show
* Buy and sell 1k
  * "buy 1k" button
  * "sell 1k"
  * exercise: "buy 100" and "sell 100" buttons
* Errors
  * error check- make sure you have enough material/latinum, show error message if you don't
  * exercise: in error message, show how much you're able to buy (to nearest integer, rounded down; give them the Round function)
  * input field- amount to buy
  * exercise: input field on how much latinum to spend (vs how much material to buy)
* Forms
  * template- edit
  * controller- edit (changeset, get)
  * controller- update (update, more changeset, pattern matching result, redirect, flash)
  * add `description` field
  * exercise: add `common_uses` field (give step by step: migration, form field, changeset, display (show and index))
  * template- new
  * controller- new
  * controller- create
* Testing
  * You know enough that testing will make sense.
  * Rest of book will be (optionally) test-first.
  * Go over generated tests one by one, going over differences between types of testing
  * Go over the "support" files
  * Create custom tests for our buy_1000 controller method- one happy path and one sad-path
  * Exercise: create custom tests for our sell_1000 controller method- one happy path and one sad-path
  * create custom Acceptance test for filling out form and adding material
  * exercise: create custom Acceptance test for filling out form and getting error (bc you didn't fill in a field.  Note that the bulk of this is handled by changesets, so you really only have to test that one fails and that the error is displayed)
<!-- now it gets a bit more abstract; each line will probably mean more work than before -->
* Events
  * Test-first your basic non-relational events (migrations, changesets, controllers, forms, displays), created step by step without generators (we're doing it so that you can get practice with the basic forms.  We'll go back to generators for the basics after this)
  * Pictures on event; first with url (and then maybe with picture upload)
  * Test-first adding belongs_to relationship of Event to Material
  * Test-first making a many-to-many relationship- multiple materials for an event
* Item_types and items
* Material requirements; construction buttons; accounting- how much of an item can you afford with current materials?  What if you destroyed all your other items?
* Users; logging in and out; permissions
* Logs  
