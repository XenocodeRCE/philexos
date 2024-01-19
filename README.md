<p align="center">
  <img width="128" height="128" src="https://github.com/XenocodeRCE/philexos/blob/main/_5f119cf4-42a9-4475-9768-f4ae87899d38.png">
</p>

# philexos
Des exercices de philosophie sous forme de textes à trous invitant à l'échange en classe.

→ Chaque fiche d'exercice dure entre 15 et 20m.

# Structure des exercices 

- Assimiler une thèse
- Mobiliser des exemples
- Aller jusqu'au concept
- Reconstruire un raisonnement
- Anticiper les objections

# Comment ça fonctionne ?

## L'API philosophèmes

On va donner du contenu à un LLM pour qu'il génère un texte précis suivant la structure juste au-dessus. Le contenu est aléatoire par défaut mais l'API prend en compte des paramètres.

L'API en question :

`https://lacavernedeplaton.fr/API/philosophemes.php`

Paramètres : 

`?p=` + le nom du philosophe
`?p=notion` + le nom de la notion au programme

Toutes les données viennent du repo "Philosophèmes" donc tout est open source.

Type de réponse : 

```json
{
  "Notion": "État",
  "Philosophe": "Mill",
  "Idée": "Ne pas intervenir dans la vie privée des individus. Mill affirme dans ce texte L’entière souveraineté de L’individu sur lui-même. L’État n’a pas à intervenir dans la vie privée des gens, sauf en cas d’actions pouvant nuire à autrui. Il ne doit pas chercher à nous rendre meilleurs."
}
```

## La génération

Le LLM (ChatGPT, Bard, Gemini, Mistral...) va générer un texte à partir des données JSON de l'API

Une façon de faire gratuite et légale est d'utiliser Poe.com pour semi-automatiser la tâche. J'ai donc une instance de LLM qui connaît la liste des philosophèmes et à qui on va donner le json.

→ https://poe.com/Platon-exo-philo

### Tout automatiser

On peut utiliser https://github.com/snowby666/poe-api-wrapper (GNU GPL3) pour totalement automatiser la tâche.

⚠️ Il faut récupérer son token Poe.com dans les cookies comme expliqué sur le repo d'origine

```python
import re
import requests
import json
from poe_api_wrapper import PoeApi


#
# On récupère le philosophème via l'API
#
url = "https://lacavernedeplaton.fr/API/philosophemes.php"
api_rep = ""
try:
    response = requests.get(url)
    if response.status_code == 200:
        api_rep = response.text
        json_data = json.loads(api_rep)
        
        notion = json_data.get("Notion")
        philosophe = json_data.get("Philosophe")
        idee = json_data.get("Idée")
        print(f"({notion}) {philosophe} → {idee}")
    else:
        print(f"Status code: {response.status_code}")

except Exception as e:
    print(f"Erreur: {e}")
    
client = PoeApi("") # votre token Poe récupéré dans les cookies
bot = "Platon-exo-philo"
message = api_rep

# Non-streamed example:
for chunk in client.send_message(bot, message):
    pass
print(chunk["text"])
```
