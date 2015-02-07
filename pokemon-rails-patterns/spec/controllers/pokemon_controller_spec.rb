require 'rails_helper'

RSpec.describe PokemonController, type: :controller do
  let!(:captured_pokemon) { FactoryGirl.create(:pokemon, caught: true) }
  let!(:free_pokemon) { FactoryGirl.create(:pokemon, caught: false) }

  describe "GET #index" do
    it "returns success" do
      get :index
      expect(response).to be_success
    end

    it "assigns captured_pokemon" do
      get :index
      expect(assigns(:captured_pokemon).to_a).to eq(Pokemon.captured.to_a)
    end

    it "calls captured on Pokemon" do
      allow(Pokemon).to receive(:captured).and_call_original
      get :index
      expect(Pokemon).to have_received(:captured)
    end

    it "calls free on Pokemon" do
      allow(Pokemon).to receive(:free).and_call_original
      get :index
      expect(Pokemon).to have_received(:free)
    end

    it "assigns types" do
      get :index
      expect(assigns(:types)).to be
    end

    context "when type is not passed" do
      it "calls by_type with nil" do
        allow(Pokemon).to receive(:by_type).with(nil).and_call_original
        get :index
        expect(Pokemon).to have_received(:by_type).twice
      end
    end

    context "when type is passed" do
      let(:type) { "dragon" }
      let(:typed_caught_pokemon) { FactoryGirl.create(:pokemon, type: type, caught: true) }
      let(:other_caught_pokemon) { FactoryGirl.create(:pokemon, type: 'electric', caught: true) }
      let(:typed_free_pokemon) { FactoryGirl.create(:pokemon, type: type, caught: false) }
      let(:other_free_pokemon) { FactoryGirl.create(:pokemon, type: 'electric', caught: false) }

      it "calls by_type method on pokemon collection" do
        allow(Pokemon).to receive(:by_type).with(type).and_call_original
        get :index, type: type
        expect(Pokemon).to have_received(:by_type).twice
      end

      it "includes pokemons of type in captured" do
        get :index, type: type
        expect(assigns(:captured_pokemon)).to include(typed_caught_pokemon)
      end

      it "doesn't include pokemons of other types in captured" do
        get :index, type: type
        expect(assigns(:captured_pokemon)).to_not include(other_caught_pokemon)
      end

      it "includes pokemons of type in free" do
        get :index, type: type
        expect(assigns(:free_pokemon)).to include(typed_free_pokemon)
      end

      it "doesn't include pokemons of other types in free" do
        get :index, type: type
        expect(assigns(:free_pokemon)).to_not include(other_free_pokemon)
      end
    end
  end

  describe "POST #catch" do
    it "assigns types" do
      post :catch, id: free_pokemon.id
      expect(assigns(:types)).to be
    end

    it "doesn't error if pokemon with id exists" do
      post :catch, id: free_pokemon.id
      expect(response).to be_redirect
    end

    it "errors if no pokemon with id" do
      expect {
        post :catch, id: -1
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "redirects to index path if no type" do
      post :catch, id: free_pokemon.id
      expect(response).to redirect_to('/pokemon')
    end

    it "redirects to type path if there's a type" do
      post :catch, { id: free_pokemon.id, type: free_pokemon.type }
      expect(response).to redirect_to("/pokemon/#{free_pokemon.type}")
    end
  end
end
