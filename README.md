# PokeMaster

Pokemon app - find them all!

This project is developed by me under the [Attribution-NonCommercial 4.0 International license](https://creativecommons.org/licenses/by-nc/4.0/).

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

### **2. `PokemonUserPokedex` Box**
This box contains the Pokédex information and all Pokémon data, facilitating global Pokémon management.

- **`Pokedex`**: A dictionary containing all Pokémon details.
- **`pokemons`**: Stores global Pokémon data for efficient access across the app.

### **3. `PokemonUserInventory` Box**
This box houses user-specific data, including inventory, team, and Poké Balls.

- **`PokeUserInventory`**: Stores all Pokémon owned by the user.
- **`UserTeam`**: Contains the user’s current Pokémon team.
- **`PokeballsUserInventory`**: Holds the user’s collection of Poké Balls.

---
