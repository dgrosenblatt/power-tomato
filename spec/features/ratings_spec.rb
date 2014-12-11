require 'spec_helper.rb'

feature 'rate a movie' do
  scenario 'user rates a movie fresh' do
    visit '/'
    fill_in 'movie', with: 'Love Actually'
    click_button 'Submit'
    click_button 'Fresh'

    expect(page).to have_content('%')
    expect(page).to have_content('agree')
  end

  scenario 'user rates a movie rotten' do
    visit '/'
    fill_in 'movie', with: "Notting Hill"
    click_button 'Submit'
    click_button 'Fresh'

    expect(page).to have_content('%')
    expect(page).to have_content('agree')
  end
end
