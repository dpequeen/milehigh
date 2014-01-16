require 'spec_helper'

describe "review section" do

  it "appears" do
    visit root_path
    click_on 'Login With Facebook'
    store = FactoryGirl.create(:store)
    expect(page).to have_content("Review Store")
  end

  it "can create a new positive review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))

    visit root_path
    click_on 'Login With Facebook'
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => 'awwwwwwwwesohm')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-up').click
    expect(page).to have_content("Your review of #{store2.name} was successfully created!")
    within("#review-feed") do
      expect(page).to have_content("awwwwwwwwesohm")
    end
  end

  it "has an error when params are missing from positive review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))

    visit root_path
    click_on 'Login With Facebook'
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => '')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-up').click
    expect(page).to have_content("Errors prevented your review from being created:")
    within("#review-feed") do
      expect(page).to_not have_content("awwwwwwwwesohm")
    end
  end

  it "can create a new negative review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))

    visit root_path
    click_on 'Login With Facebook'
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => 'awwwwwwwwesohm')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-down').click
    expect(page).to have_content("Your review of #{store2.name} was successfully created!")
    within("#review-feed") do
      expect(page).to have_content("awwwwwwwwesohm")
    end
  end

  it "has an error when params are missing from negative review", :js => true do
    store = FactoryGirl.create(:store)
    store2 = FactoryGirl.create(:store, name: "snoop's house")
    store2.reviews.create(FactoryGirl.attributes_for(:review))

    visit root_path
    click_on 'Login With Facebook'
    fill_in("store_name", :with => "snoop's house")
    click_on 'Review Store'
    expect(page).to have_content("Review snoop's house")
    fill_in('Title', :with => '')
    fill_in('review_body', :with => 'truuuuuly delish nug')
    find('#thumbs-down').click
    expect(page).to have_content("Errors prevented your review from being created:")
    within("#review-feed") do
      expect(page).to_not have_content("awwwwwwwwesohm")
    end
  end

end
