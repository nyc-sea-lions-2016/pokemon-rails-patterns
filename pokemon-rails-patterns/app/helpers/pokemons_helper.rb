module PokemonsHelper
  def pokemon_class(pokemon)
    pokemon_type_class(pokemon.type)
  end

  def pokemon_type_class(pokemon_type)
    "#{pokemon_type} pokemon-type"
  end

  def pokemon_image_attributes(pokemon)
    { onerror: "this.onerror=null;this.src='/assets/new_pokemon.png'" }
  end

  def pokemon_image_tag(pokemon)
     image_tag pokemon.image_url, pokemon_image_attributes(pokemon)
  end

  def pokemon_action_path(pokemon)
    "#{pokemon_action(pokemon)}/#{pokemon.id}"
  end

  def pokemon_action_text(pokemon)
    "#{pokemon_action(pokemon).camelize}!"
  end

  private

  def pokemon_action(pokemon)
    pokemon.caught ? "release" : "catch"
  end
end
