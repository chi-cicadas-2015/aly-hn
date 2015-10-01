require 'rails_helper'

feature "Posts" do

  background do
    @user = User.create!(email: "email@email.com", first_name: "First", last_name: "Last", password: "123")
  end

  feature "creating a post" do

    scenario "when a user is logged in" do
      login(@user)
      click_link 'New Post'

      fill_in 'post[title]', with: "My Post"
      fill_in 'post[body]', with: "Post Body"
      click_button 'Create'

      expect(page).to have_content "My Post"
    end

    scenario "when a user does not fill in required fields" do
      login(@user)
      click_link 'New Post'
      click_button 'Create'

      expect(page).to have_content "Create Post"
    end

    scenario "when a user is not logged in" do
      visit root_path
      expect(page).to_not have_content "New Post"
    end

    scenario "when a not logged in user navigates to the new post form" do
      visit new_post_path
      expect(page).to_not have_content "Create Post"
    end
  end

  after do
    User.destroy_all
    Post.destroy_all
  end
end