https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## Cursor IDE GPT-5 AI model

**It generated code for ~6 minutes.**
Used tokens:
```
Cache Read: 915 712
Cache Write: 0
Input: 53 984
Output: 18 069
Total: 987 765
```
"Cost" calculated by cursor.com `0,36 USD` - included in 20 USD subscriptions.


**Code probably works (heals).**

It added life steal to HP change, but not to MP change. Life steal won't work if you hit a player with a mana shield, but I can't say that it's wrong as I did not specify it in the prompt. "lifesteal" stealing only when you deal damage to "life" is ok.

It says that it added it to the description of items, but it added it only to melee weapons and armors, not to all items.

It implemented this attribute effectively using Moveevents onEquip/onDeEquip to recalculate life steal percent only on item change.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```