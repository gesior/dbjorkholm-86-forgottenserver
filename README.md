https://github.com/dbjorkholm/forgottenserver/tree/8.6 copy with AI changes in PRs

## CLion with Claude Agent plugin
It's the first attempt to add a "lifesteal" attribute. All prompts in Polish and I had to tell AI to add/fix many things. Next attempts will use full instruction in English as one prompt.

6 prompts:
```
musze dodac atrybut "lifesteal" do itemow,
ktory bedzie zawieral procent zycia jaki ma odzyskac gracz, kiedy zadaje obrazenia
trzeba dodac wczytywanie tego atrubutu z items.xml i leczenie gracza, 
kiedy zadaje obrazena o tyle, ile wynosi suma procent z itemow, ktore ma w slotach  

wartosc lifesteal powinna sie tez pokazywac w opisie przedmiotu, kiedy gracz na niego patrzy

dodaj wysylanie wiadomosci do gracza o tym ile zycia odzyskal uzywajac typu wiadomosci MESSAGE_STATUS_DEFAULT

gracz nie moze sie leczyc powyzej maksymalnej ilosci zycia,
wysylaj wiadomosc tylko jak gracz realne zyskuje jakies zycie i pokazuje realnie dodana wartosc

nie w kazdym opisie przedmiotu pojawia sie informacja o atrybucie 'life leech', popraw to

bez dodania tej zmiany i tak bylo by widac kiedy wartosc nie jest zerem
problemem jest to, ze jest wiele typow przedmiotow i pewnie przedmiot,
ktory testuje nie jest w IFach aktualnie dodanych
```