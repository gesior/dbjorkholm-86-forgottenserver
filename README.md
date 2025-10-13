https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## Cursor IDE GPT-5-codex AI model with "plan"

Some YT recommended first running your prompt with the "Plan" option in Cursor and clicking "Build" to generate code. I tried it, but it costs more and the code isn't much better. At least with the GPT-5-codex model.

**It generated plan and code for ~10 minutes.**

Plan used tokens:
```
Cache Read: 1 492 608
Cache Write: 0
Input: 141 711
Output: 11 974
Total: 1 646 293
```
"Cost" calculated by cursor.com `0,48 USD` - included in 20 USD subscriptions.

Build used tokens:
```
Cache Read: 813 568
Cache Write: 0
Input: 131 210
Output: 11 315
Total: 956 093
```
"Cost" calculated by cursor.com `0,38 USD` - included in 20 USD subscriptions.

Total: `0,86 USD`. Starting in agent mode, it costs only `0.30 USD`.

**Code probably works.**

It added life steal to HP change, but not to MP change. Life steal won't work if you hit a player with a mana shield, but I can't say that it's wrong as I did not specify it in the prompt. "lifesteal" stealing only when you deal damage to "life" is ok.

It says that it added it to the description of items, but it added it wrong. It totally destroyed the description of items code. It will appear in every item description, but rest of description will look wrong like `(Atk: 30 (Lifesteal: 5%), Def: 20)` - adds extra `(` and `)` around "Lifesteal" no matter what.

It also added some random line modification to the code in line not related to changes (removed 1x`TAB`, so code is not indented properly).

It used some of the movements.cpp code in player.cpp, instead of saving CPU, it uses more and replicates movements.cpp logic - GPT-5 (not codex) used movements.cpp to save CPU.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```