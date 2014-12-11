require 'spec_helper.rb'

feature 'get recommendations' do
  scenario 'user visits recommendations page' do
    visit '/'
    fill_in 'movie', with: 'Toy Story'
    click_button 'Submit'
    click_button 'Fresh'
    click_link   'Recommendations'

    expect(page).to have_content('Here are your PowR Tomatoes!')
    expect(page).to have_content('Seems like you have the same taste as:')
    expect(page).to have_content('You might also enjoy:')
  end
end
