class PokemonController < ApplicationController
  before_action :set_type, only: [:index, :catch]

  def index
    #Searching
    @captured_pokemon = Pokemon.captured.by_type(params[:type]).ordered
    @free_pokemon = Pokemon.free.by_type(params[:type]).ordered
  end

  def catch
    #Validations: Allowed to catch pokemon that follow the following rules:
    # you don't already have it
    # you don't already have 2 pokemon of that type
    found_pokemon = Pokemon.find(params[:id])

    if found_pokemon.catch
      NotificationService.tell_friends "I caught #{found_pokemon.name.upcase}!"
    else
      flash[:notice] = "damn Damn DAMN! #{found_pokemon.name.upcase} got away!"
    end

    redirect_with_type

  end

  def release
    found_pokemon = Pokemon.find(params[:id])
    found_pokemon.caught = false
    found_pokemon.save

    release_message = "#{found_pokemon.name} was released back into the wild"
    flash[:notice] = release_message
    NotificationService.tell_friends release_message

    redirect_with_type
  end

  private

  def set_type
    @types = Pokemon::TYPES
  end

  def redirect_with_type
    if params[:type].present?
      redirect_to pokemon_type_path(params[:type])
    else
      redirect_to pokemon_index_path
    end
  end
end
