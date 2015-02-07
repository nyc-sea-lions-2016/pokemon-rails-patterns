require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  let(:captured_pokemon) { FactoryGirl.create(:pokemon, caught: true) }
  let(:free_pokemon) { FactoryGirl.create(:pokemon, caught: false) }

  describe "scopes" do
    describe "validations" do
      describe "#only_two_of_type" do
        let(:pokemon) { FactoryGirl.build(:pokemon, type: captured_pokemon.type, caught: true) }

        context "when there are at least 2 of type already caught" do
          before do
            FactoryGirl.create(:pokemon, type: captured_pokemon.type, caught: true)
          end

          it "doesn't not save" do
            expect {
              pokemon.catch
            }.to_not change { Pokemon.captured.count }
          end

          it "has a caught error" do
            pokemon.catch
            expect(pokemon.errors[:caught]).to include("has too many of type")
          end

          it "doesn't save when updating from free to caught" do
            pokemon = FactoryGirl.create(:pokemon, type: captured_pokemon.type, caught: false)
            expect(pokemon.catch).to be_falsy
          end

          it "does create a new free pokemon of type" do
            pokemon = FactoryGirl.build(:pokemon, type: captured_pokemon.type, caught: false)
            expect(pokemon.save).to be_truthy
          end
        end

        context "when there are none of type captured" do
          before do
            Pokemon.captured.by_type(captured_pokemon.type).delete_all
          end

          it "saves" do
            expect {
              pokemon.catch
            }.to change { Pokemon.captured.count }
          end

          it "not have any errors" do
            pokemon.catch
            expect(pokemon.errors).to be_empty
          end
        end
      end
    end


    describe "#captured" do
      it "only includes captured pokemon" do
        expect(Pokemon.captured).to include(captured_pokemon)
      end

      it "doesn't include free pokemon" do
        expect(Pokemon.captured).to_not include(free_pokemon)
      end
    end

    describe "#free" do
      it "only includes free pokemon" do
        expect(Pokemon.free).to include(free_pokemon)
      end

      it "doesn't include captured pokemon" do
        expect(Pokemon.free).to_not include(captured_pokemon)
      end
    end

    describe ".by_type" do
      let(:type) { "fairy" }
      let(:fairy_pokemon) { FactoryGirl.create(:pokemon, type: type) }
      let(:other_pokemon) { FactoryGirl.create(:pokemon, type: 'bug') }

      context "when type is passed" do
        it "include pokemon of passed type" do
          expect(Pokemon.by_type(type)).to include(fairy_pokemon)
        end

        it "doesn't include pokemon of other types" do
          expect(Pokemon.by_type(type)).to_not include(other_pokemon)
        end
      end

      context "when type is nil" do
        it "includes fairy pokemon" do
          expect(Pokemon.by_type(nil)).to include(fairy_pokemon)
        end

        it "includes other pokemon" do
          expect(Pokemon.by_type(nil)).to include(other_pokemon)
        end
      end
    end
  end

  describe "#catch" do
    it "set caught to true" do
      free_pokemon.catch
      expect(free_pokemon.caught).to be_truthy
    end

    it "save our pokemon" do
      allow(free_pokemon).to receive(:save)
      free_pokemon.catch
      expect(free_pokemon).to have_received(:save)
    end
  end
end
