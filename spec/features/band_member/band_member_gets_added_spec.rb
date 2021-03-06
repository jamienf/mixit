require "rails_helper"

feature "Band owner adds new member", %q(
As a band owener
I want to be the band owner when I create it
So that someone can manage our band settings

Acceptance Criteria
[ ] I must be able to add users to my band
[ ] I must not be able to add band members to another band
[ ] I must only be able to add users that have signed up
) do

  before :each do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
    @band1 = FactoryGirl.create(:band)
  end

  scenario "Band owner adds a new member", focus: true do
    sign_in_as(@user1)

    click_button "Create new band"
    expect(page).to have_content "Fill out the form below to create a new band"
    fill_in "Name", with: @band1.name
    fill_in "Bio", with: @band1.bio
    fill_in "Genre", with: @band1.genre
    click_button "Submit Band"

    expect(page).to have_content "#{@user1.email}"
    click_link "Add Band Member"

    expect(page).to have_content "Fill out the form below to add a band member"
    fill_in "email", with: @user2.email
    click_button "Submit Member"

    expect(page).to have_content "#{@user1.email}"
    expect(page).to have_content "#{@user2.email}"
  end
end
