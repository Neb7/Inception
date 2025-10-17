# Inception
Inception project


co a la db
changer article
co 2 user
redemarer vm
fonction container

Le fonctionnement de Docker repose sur le noyau Linux et les fonctions de ce noyau, comme les groupes de contrôle cgroups et les espaces de nom. Ce sont ces fonctions qui permettent de séparer les processus pour qu’ils puissent s’exécuter de façon indépendante. En effet, le but des conteneurs est d’exécuter plusieurs processus et applications séparément. C’est ce qui permet d’optimiser l’utilisation de l’infrastructure sans pour autant atténuer le niveau de sécurité par rapport aux systèmes distincts.


Docker Compose en bref (simple et concret) :
Quoi : outil pour définir et lancer une application multi-conteneurs avec un fichier YAML (services, réseaux, volumes, variables).
But : démarrer plusieurs conteneurs liés (ex. nginx + wordpress + mariadb) d’un seul coup, avec configuration reproductible.


Image Docker = un paquet immuable contenant l’OS minimal + ton appli et ses dépendances. Tu peux la lancer seule avec docker run.
Docker Compose = un outil pour définir et lancer plusieurs conteneurs/services (chaîne d’images) et leurs relations (réseaux, volumes, variables) à partir d’un fichier YAML.

Limites (en bref) : moins d’isolation kernel-level que VM (sécurité/compatibilité), pas de noyau personnalisé.


