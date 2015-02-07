require 'rails_helper'
RSpec.describe PokemonsHelper, type: :helper do
  let(:pokemon) { FactoryGirl.create(:pokemon, type: 'fairy') }

  describe "#pokemon_class" do
    it "returns a string with type and 'pokemon-type'" do
      expect(pokemon_class(pokemon)).to eq("fairy pokemon-type")
    end
  end

  describe "#pokemon_image_attributes" do
    it "returns a hash" do
      expect(pokemon_image_attributes(pokemon)).to be_a(Hash)
    end

    it "returns onerror" do
      attrs = pokemon_image_attributes(pokemon)
      expect(attrs[:onerror]).to eq(
        "this.onerror=null;this.src='/assets/new_pokemon.png'"
      )
    end
  end

  describe "#pokemon_action_path" do
    it "returns release path when caught" do
      pokemon.catch
      expect(pokemon_action_path(pokemon)).to eq("release/#{pokemon.id}")
    end

    it "returns catch path when free" do
      pokemon.update(caught: false)
      expect(pokemon_action_path(pokemon)).to eq("catch/#{pokemon.id}")
    end
  end

  describe "#pokemon_action_text" do
    it "returns Release! when caught" do
      pokemon.catch
      expect(pokemon_action_text(pokemon)).to eq("Release!")
    end

    it "returns Catch! path when free" do
      pokemon.update(caught: false)
      expect(pokemon_action_text(pokemon)).to eq("Catch!")
    end
  end
end
