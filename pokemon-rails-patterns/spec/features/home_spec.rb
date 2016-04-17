require 'rails_helper'
RSpec.describe 'Home page' do

  context 'index page' do
    it 'has sections for captured free and filters' do
      visit '/'
      expect(page).to have_selector('#captured_pokemon')
      expect(page).to have_selector('#free_pokemon')
      expect(page).to have_selector('#filters')
    end

    it 'allows pokemon to be caught' do
      p = FactoryGirl.create(:pokemon, caught: false)
      visit '/'
      click_button('Catch!')
      expect(page).to have_selector('#captured_pokemon form[action="/release/' + p.id.to_s + '"]')
    end

    it 'will only catch two of one type' do
      FactoryGirl.create(:pokemon, type: 'fire', caught: true)
      FactoryGirl.create(:pokemon, type: 'fire', caught: true)
      p = FactoryGirl.create(:pokemon, type: 'fire', caught: false)
      visit '/'
      click_button('Catch!')
      expect(page).to have_content("damn Damn DAMN! #{p.name.upcase} got away!")
    end

    it 'can release a pokemon' do
      p = FactoryGirl.create(:pokemon, caught: true)
      visit '/'
      click_button('Release!')
      expect(page).to have_content("#{p.name} was released back into the wild ")
    end

    it 'can filter by type' do
      f = FactoryGirl.create(:pokemon, type: 'fire')
      w = FactoryGirl.create(:pokemon, type: 'water')
      visit '/'
      click_link('fire')
      expect(page).to have_content(f.name)
      expect(page).not_to have_content(w.name)
      click_link('water')
      expect(page).to have_content(w.name)
      expect(page).not_to have_content(f.name)
    end


  end
end

