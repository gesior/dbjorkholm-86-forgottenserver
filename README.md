https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## CLion with Junie Pro (beta) plugin with "extra thinking"
`Junie Pro (beta)` is a plugin for CLion IDE made by CLion authors.

On the first run with "extra thinking" it failed after around 1 minute with an API error about "too problematic request".

**It generated code for ~5 minutes. It does not report tokens used.**

It does not work at all. It reported in an agent window that it added code to modify player health, but it did not modify it.
It says that it added it to description of items, but it added it only to armors, not to all items.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```