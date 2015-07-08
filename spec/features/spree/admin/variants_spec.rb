require 'spec_helper'

RSpec.describe 'Labels management on variants', type: :feature do

  let!(:user) {create(:admin_user)}
  let!(:variant) {create(:variant)}
  let!(:label){create(:label)}

  before do
    4.times {create(:label)}
    sign_in_admin! user
  end

  it 'must add a label to a variant' do
    visit spree.edit_admin_product_variant_path(variant.product, variant.id)
    expect(page).to have_selector('div[data-hook="labels"] ul li', minimum: 5)
    check label.name
    find('button[type="submit"]').click
    expect(page).to have_content 'successfully updated!'
    expect(variant.labels).to include(label)
  end

end