## Cursor IDE with "auto" AI model

"auto" AI model in Cursor IDE is unlimited with 20 USD/month subscription.

If you use other models (GPT/Claude) too much (ex. 50 USD of tokens on 20 USD/month subscription), you lose access to selecting model until the end of the month, but you can still use "auto" model. You can also with to pay-as-you-go subscription and pay for all models usage.

**It generated code for ~5 minutes.**
Used tokens:
```
Cache Read: 3 930 826
Cache Write: 161 573
Input: 26 288
Output: 10 091
Total: 4 128 778
```
"Cost" calculated by cursor.com `1,28 USD` - included (right now unlimited) in 20 USD subscriptions.


**Code probably works (heals).**

It added life steal to HP change, but not to MP change. Life steal won't work if you hit a player with a mana shield, but I can't say that it's wrong as I did not specify it in the prompt. "lifesteal" stealing only when you deal damage to "life" is ok.

It says that it added it to the description of items, but it added it only to armors, not to all items.

It also generated a lot of documentation files.

1 prompt:
```
add new item attribute called "lifesteal" that defines percentage of health player recovers when they deal damage
implement following features:
- load "lifesteal" attribute from items.xml
- when player deals damage, heal them by total lifesteal percentage from all equipped items
- display lifesteal value in item description when player look on it
- send message to player with information how much health they recovered using message type MESSAGE_STATUS_DEFAULT, only send message when player actually gains health, displayed value must show real amount healed
```