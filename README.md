# PokeMaster

Pokemon app - find them all!

This project is developed by me under the [Attribution-NonCommercial 4.0 International license](https://creativecommons.org/licenses/by-nc/4.0/).

## And just some favorite poke gifs
- ![493](https://github.com/user-attachments/assets/b420a606-3d44-4f4d-902e-1c2188a6c081)
![384](https://github.com/user-attachments/assets/358d5087-acec-428d-82ff-73ea39046b87)![483](https://github.com/user-attachments/assets/1cbcd863-63ce-40b0-9716-79cecb6d6389)![484](https://github.com/user-attachments/assets/3a0693b1-4394-4da9-bca9-d8f143115129)![487](https://github.com/user-attachments/assets/83d3c1e9-cff7-432c-a8ed-2b57cc60dc41)![350](https://github.com/user-attachments/assets/c21df2d1-0ecd-42a8-99c0-0e1f0df9f513)
---

## 🌳 Project Ideology

As a lifelong Pokémon enthusiast, I set out to create a Pokémon game that captures the excitement of capturing, training, and exploring with any Pokémon you’ve ever dreamed of. This project is entirely free, works offline, and provides users with the freedom to save or retrieve their progress from the cloud seamlessly. 

### Project Highlights

- **📖 Pokédex Tracking**: Track your personal journey through the Pokédex, seeing all Pokémon you’ve encountered or captured along the way.
- **🎲 Map Screen - The Pokémon Roulette**: An interactive roulette on the map screen gives users the chance to obtain new Pokémon randomly—spin the wheel and see which Pokémon is destined to join your team!
- **🎒 Inventory Management**: Take full control of your Pokémon on the inventory screen, where you can add or remove team members, view detailed stats, evolve Pokémon, or even release them back into the wild. Your Pokémon journey is truly in your hands!
- **🏆 Challenge Screen**: Step up and prove your strength by battling against the most formidable gym leaders and contest champions. Earn stars, unlock achievements, and aim to be legendary in the Pokémon world!

### Screens Overview

1. **🏪 Store Screen**: Visit the store to purchase Poké Balls and view your current inventory of essential items.
2. **🎒 User Inventory**: View and manage all your Pokémon and items here—organize your team and prepare for adventure!
3. **🗺️ Map Page**: Explore the world map to search for locations and discover Pokémon from every region.
4. **⚔️ Challenge Page**: Test your might against the strongest opponents and cement your place as a champion.
5. **📚 Pokédex Page**: Your ultimate guide to the Pokémon world! Track all Pokémon, read detailed information, and see which ones you've yet to encounter.

---

## 📷 Images and GIFs
All Pokémon images and GIFs are stored within the project under two main directories:

- **Path for GIFs**: `assets/gifs` - Contains animated GIFs of all Pokémon.
- **Path for Images**: `assets/pokeimages` - Contains images for various features such as gyms, contests, and more.

**Special Thanks**  
We extend our gratitude to [Bulbapedia](https://bulbagarden.net/home/) and the community of [r/PokemonRMXP](https://www.reddit.com/r/PokemonRMXP/) for providing the images and GIFs used in this project. ❤️

---

## 📊 Database Structure

The application uses a structured database approach to manage user data, challenges, and the Pokédex efficiently. Below are the key components and their roles:

### **1. `PokemonUserDataBase` Box**
This box contains data related to user challenges, contests, and user currency.

- **`PokeChallenge`**: Stores all challenges for the user.
- **`PokeContest`**: Stores all contest data for the user.
- **`UserMoneys`**: Holds the user’s gold balance.
- **`initialized`**: Holds if system initialized.

### **2. `PokemonUserPokedex` Box**
This box contains the Pokédex information and all Pokémon data, facilitating global Pokémon management.

- **`Pokedex`**: A dictionary containing all Pokémon details.
- **`pokemons`**: Stores global Pokémon data for efficient access across the app.

### **3. `PokemonUserInventory` Box**
This box houses user-specific data, including inventory, team, and Poké Balls.

- **`PokeUserInventory`**: Stores all Pokémon owned by the user.
- **`PokeballsUserInventory`**: Holds the user’s collection of Poké Balls.

### **4. `PokemonUserTeam` Box**
This box houses user pokemons team.
- **`UserTeam`**: Contains the user’s current Pokémon team.
  
---

## 📜🏛️ History of development

Here links how project started and all way throw development :
- [Project start](https://www.linkedin.com/posts/tashtanov_github-tashtemirlanpokemaster-pokemon-activity-7250876090334810112-bcAk?utm_source=combined_share_message&utm_medium=member_desktop_web)
- [First steps](https://www.linkedin.com/pulse/pokedex-pokeroulette-temirlan-tashtanov-fo5de/?trackingId=4FtVEHjiKPw0RDq%2Bpj3wTg%3D%3D)
- [Major update](https://www.linkedin.com/pulse/pokemaster-v20-temirlan-tashtanov-ttfce/?trackingId=Lb4smk61zxIAIHJ3A7O2VQ%3D%3D)
- [Release](https://www.linkedin.com/pulse/pokemaster-release-temirlan-tashtanov-prpae)
---

## 📄 Dart Code Database Structure

The following code snippet defines the `PokedexPokemonModel` class structure in Dart, used to store and manage Pokedex data in the application.

```dart
@HiveType(typeId: 0)
class PokedexPokemonModel{
  @HiveField(0)
  final Pokemon pokemon;

  @HiveField(1)
  final bool isFound;

  const PokedexPokemonModel({
    required this.pokemon,
    required this.isFound,
  });
}
```

The following code snippet defines the `Pokemon` class structure in Dart, used to store and manage Pokemon data in the application.

```dart
@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  int pokeDexIndex;

  @HiveField(1)
  String name;

  @HiveField(2)
  Rarity rarity;

  @HiveField(3)
  List<PokeType> type;

  @HiveField(4)
  PokeStats pokeStats;

  @HiveField(5)
  Region region;

  @HiveField(6)
  List<PokeType?> weakness;

  @HiveField(7)
  String gifFront;

  @HiveField(8)
  String gifBack;

  Pokemon({
    required this.pokeDexIndex,
    required this.name,
    required this.rarity,
    required this.type,
    required this.pokeStats,
    required this.region,
    required this.weakness,
    required this.gifFront,
    required this.gifBack,
  });
}
```

The following code snippet defines the `PokeStats` class structure in Dart, used to store and manage Pokemon stats data in the application.

```dart
@HiveType(typeId: 2)
class PokeStats {
  @HiveField(0)
  double hp;

  @HiveField(1)
  double attack;

  @HiveField(2)
  double defence;

  @HiveField(3)
  double specialAttack;

  @HiveField(4)
  double specialDefence;

  @HiveField(5)
  double speed;

  PokeStats({
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
  });
}
```

The following code snippet defines the `PokeAwards` class structure in Dart, used to store and manage Pokemon Awards data in the application.

```dart
@HiveType(typeId: 6)
class PokeAwards{
  @HiveField(0)
  final String awardImagePath;

  @HiveField(1)
  final bool obtained;

  @HiveField(2)
  final String awardName;

  @HiveField(3)
  final String cityName;

  const PokeAwards({
    required this.awardImagePath,
    required this.obtained,
    required this.awardName,
    required this.cityName
  });
}
```

The following code snippet defines the `PokemonUser` class structure in Dart, used to store and manage Pokemon User data in the application.

```dart
@HiveType(typeId: 7)
class PokemonUser{
  @HiveField(0)
  final Pokemon pokemon;

  @HiveField(1)
  final int lvl;

  @HiveField(2)
  final String hashId;

  const PokemonUser({
    required this.pokemon,
    required this.lvl,
    required this.hashId
  });
}
```

---

## 📸 Screenshots

Take a closer look at some screenshots highlights of the project:
![Screenshot_2024-11-30-13-03-46-324_com teit pokemonmap](https://github.com/user-attachments/assets/5e3ed041-21fe-457f-8214-db5e7e7e44dc)
![Screenshot_2024-11-30-13-04-44-086_com teit pokemonmap](https://github.com/user-attachments/assets/5125d0a0-60eb-4e1f-921c-59cf7696c93f)
![Screenshot_2024-11-30-13-04-51-781_com teit pokemonmap](https://github.com/user-attachments/assets/86af0c56-6154-4709-8851-7c9db70c233a)
![Screenshot_2024-11-30-13-05-25-563_com teit pokemonmap](https://github.com/user-attachments/assets/8b834663-f688-4857-8473-eca85fc23aeb)
![Screenshot_2024-11-30-13-05-04-692_com teit pokemonmap](https://github.com/user-attachments/assets/57e5f20c-4582-4365-a420-991bd2915bf9)
![Screenshot_2024-11-30-13-05-18-800_com teit pokemonmap](https://github.com/user-attachments/assets/2b987e35-6fae-4c26-8b77-9cfcb69938d3)
![Screenshot_2024-11-30-13-05-43-723_com teit pokemonmap](https://github.com/user-attachments/assets/b43455ca-ef86-4b07-909a-88ead79a3621)
![Screenshot_2024-11-30-13-05-48-825_com teit pokemonmap](https://github.com/user-attachments/assets/b9058cda-2947-4688-b136-9a7e9efaf49d)
---

## 🙏 Thanks & Support

Thank you for exploring **PokeMaster**! If you enjoyed the project, consider giving it a ⭐ on GitHub. Your support helps me continue building and improving this project. 

**Follow me** : [GitHub Profile](https://github.com/tashtemirlan)
