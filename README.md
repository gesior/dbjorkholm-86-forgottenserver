https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## CLion with Claude Agent plugin
It's the second attempt to add a "lifesteal" attribute. This time with just 1 prompt.

**It generated code for 290 seconds and used 90k input and 13k output tokens.**

IDK if it works (heals player), but it made this attribute like attribute savable in a database, but it does not save it in database/load from a database.
Item description is added only in 1 place, instead of at least 3 required to make this attribute display for every item.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```