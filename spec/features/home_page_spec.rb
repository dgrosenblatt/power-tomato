require 'spec_helper.rb'

feature 'display helpful information on home page' do
  scenario 'user visits home page' do
    visit '/'

    expect(page).to have_content('Find your PowR Tomato')
    expect(page).to have_content('A PowR Tomato is a movie critic that shares your filmological taste.')
  end
end

feature 'search for a movie' do
  scenario 'user searches for a movie that exists' do
    visit '/'
    fill_in 'movie', with: 'Agent Cody Banks 2'
    click_button 'Submit'

    expect(page).to have_content('Agent Cody Banks 2')
  end

  scenario 'user searches for a movie that resutrns no results' do
    visit '/'
    fill_in 'movie', with: 'Secret Agent Cody Banks 2'
    click_button 'Submit'

    expect(page).not_to have_content('starring')
  end
end

feature 'clear results' do
  scenario 'user starts over' do
    visit '/'
    fill_in 'movie', with: 'Forgetting Sarah Marshall'
    click_button 'Submit'
    click_button 'Fresh'
    click_button 'Start over'

    expect(page).to have_content('Find your PowR Tomato')
    expect(page).to have_content('A PowR Tomato is a movie critic that shares your filmological taste.')
    expect(page).to_not have_content('%')
    expect(page).to_not have_content('agreed')
    expect(page).to_not have_content('Show all critics')
  end
end
