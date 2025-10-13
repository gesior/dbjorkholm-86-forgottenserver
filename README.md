https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## Cursor IDE GPT-5 AI model with "plan"
Some YT recommended first running your prompt with the "Plan" option in Cursor and clicking "Build" to generate code.
Response is a bit better, but the cost is over 2x higher.

**It generated plan and code for ~10 minutes.**

Plan used tokens:
```
Cache Read: 374 272
Cache Write: 0
Input: 34 096
Output: 12 013
Total: 420 381
```
"Cost" calculated by cursor.com `0,21 USD` - included in 20 USD subscriptions.

Build used tokens:
```
Cache Read: 2 066 688
Cache Write: 0
Input: 99 973
Output: 8115
Total: 2 174 776
```
"Cost" calculated by cursor.com `0,46 USD` - included in 20 USD subscriptions.

Total: `0,67 USD`. Starting in agent mode, it costs only `0.30 USD`.

**Code probably works.**

It added life steal to HP change, but not to MP change. Life steal won't work if you hit a player with a mana shield, but I can't say that it's wrong as I did not specify it in the prompt. "lifesteal" stealing only when you deal damage to "life" is ok.

It says that it added it to the description of items, but it added it only to melee weapons, armors and 'else' items, not to all items. It did not add it to 'distance weapons', but it's the first AI model to add it to 'else' items. Greatest model of all for item description.

It did not use `movements.cpp` events to reduce CPU usage - like it did without "Plan" -, but at least code worked.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```