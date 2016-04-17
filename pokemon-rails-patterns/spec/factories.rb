p_names = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Clefairy", "Clefable", "Vulpix", "Ninetales", "Zubat", "Golbat", "Paras", "Parasect", "Diglett", "Dugtrio", "Psyduck", "Mankey", "Primeape", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Magnemite", "Magneton", "Drowzee", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Tangela", "Mr-mime", "Jynx", "Omanyte", "Omastar", "Kabuto", "Kabutops", "Dratini", "Jim", "Dragonair"]
p_types = ["fire", "electric", "normal", "water", "fairy", "grass", "steel", "fighting", "dragon", "bug", "poison", "flying", "s", "ice", "ground", "psychic", "rock"]
p_attack = [64, 70, 82, 45, 48, 55, 83, 84, 1, 80, 90, 30, 60, 50, 95, 56, 40, 62, 100, 105, 41, 115, 35, 75, 52, 76, 20, 49, 63]
p_defense = [85, 70, 43, 45, 55, 48, 25, 83, 58, 15, 1, 125, 80, 90, 30, 78, 60, 50, 73, 95, 40, 100, 105, 115, 65, 35, 75, 110, 49, 63]
p_hp = [70, 45, 25, 55, 83, 58, 1, 79, 10, 38, 80, 90, 30, 60, 78, 59, 50, 39, 95, 73, 40, 41, 35, 75, 65, 61, 44, 63]
FactoryGirl.define do
  factory :pokemon do
    name { p_names.sample }
    type { p_types.sample }
    hp { p_hp.sample }
    attack { p_attack.sample }
    defense { p_defense.sample }
    caught { [false, true].sample }
  end
end
