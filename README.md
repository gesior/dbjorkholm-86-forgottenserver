https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## Cursor IDE GPT-5-codex AI model

**It generated code for ~15 minutes.**
Used tokens:
```
Cache Read: 896 128
Cache Write: 0
Input: 127 617
Output: 2489
Total: 1 026 234
```
"Cost" calculated by cursor.com `0,30 USD` - included in 20 USD subscriptions.

BUT cursor.com billing stopped around the fourth minute of the run. So IDK, if it really used just these tokens or their cost calculator failed to report real cost of my request.


**Code does not work.**

It added 'lifesteal' code to the 'heal' function, so it "life steals" when you heal another player?!

It says that it added it to the description of items, but it added it only to melee weapon, not to all items.

It also added some random line modification to the code in line not related to changes (removed 2x`TAB`, so code is not indented properly).

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