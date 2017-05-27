Our basic project is the inventory app.  It's used for keeping track of the ship items, the replicator materials, and the material inputs required for each of the ship items.

We call it "Star Track".

Tables:
* materials
* events
* item_types
* items
* input_requirements

## Materials

Number of materials records will always be relatively low.  Have technobabble names.  The major fields will be "name", "description", and "amount_stored".

## Events

Events first belong_to a material, and add or remove amount.  Removal ones have validations.

Then- optional- turn it into a has_many: :through with multiple changes per event

## Item_types

Lots of different items possible.  Once again technobabble names for the gadgets, then stuff like food and home decor items.  Major fields will be "name", "description".

## items

This is to demonstrate the has_many/belongs_to relationship.  Each item belongs_to an item_type.  Fields are "item_type_id", "created_at", "usage" (usage being strings like "food for Johnny" or "weapon for storage in armory")

## input_requirements

This is to demonstrate has_many: :through (or Elixir equivalent).  Each item_type has a certain amount of each material that is required to make it.  It also has reverse (salvage) values that can be recovered.  Major fields are "item_type_id", "material_id", "amount", "salvage".

## Major Functions

The following are the major side-effect functions:

* ItemType.create(item_type) -> removes materials, adds one item.  If not enough of one of materials throws an error
* Item.consume(item) -> removes item
* Item.salvage(item) -> removes item, adds back some materials

The following are the major informational functions:

* ItemType.number_can_create(item_type) -> how many could be created with current materials
* Material.total_salvageable_amount(material, items) -> pass in all items you don't need, figure out how much total stuff you could get for this specific material
* Material.total_salvageable_amount(items) -> pass in all items you don't need, get back hash of what your materials would be
* ItemType.number_can_create(item_type, {material_hash}) -> how many could be created with passed-in materials

# Tracking

Later we add tracking to see who's signing in and creating stuff

* Users
* Sessions
* Logs

Logs belong_to :user, belong_to :item_type, belong_to :item, have a verbose record stored both for outputting quickly and just in case user or item gets deleted
