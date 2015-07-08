require 'spec_helper'

RSpec.describe 'Label CRUD', {type: :feature, js: true} do

  let!(:user) {create(:admin_user)}
  let!(:label) {create(:label)}

  before do
    sign_in_admin! user
  end

  describe 'index' do

    before { 10.times{create(:label)} }

    before :each do
      visit spree.admin_labels_path
    end

    context 'listing' do

      it 'must list all labels' do
        expect(page).to have_selector('tr[data-hook="admin_labels_index_rows"]', count: 10)
      end

    end

    context 'filtering' do

      before do
        create(:label, name: 'Filtering Test')
      end

      it 'must filter using a quick search' do
        within find('#quick-search') do
          fill_in 'quick_search', with: 'Filtering Test'
          find('.js-quick-search').native.send_keys(:Enter)
        end
        expect(page).to have_selector('tr[data-hook="admin_labels_index_rows"]', count: 1)
      end

      it 'must be filtered by name' do
        find('.js-show-index-filters').click
        expect(page).to have_selector('#table-filter')
        fill_in 'q[name_cont]', with: 'Filtering Test'
        find('button[type="submit"]').click
        expect(page).to have_selector('tr[data-hook="admin_labels_index_rows"]', count: 1)
      end

    end

  end

  describe 'create' do

    before :each do
      visit spree.new_admin_label_path
    end

    context 'without errors' do

      it 'must create the label and redirect to the listing with a success message' do
        within find('#new_label') do
          fill_in 'label[name]', with: 'Label test'
          fill_in 'label[color]', with: '#CC0000'
          find('button[type="submit"]').click
        end
        expect(page).to have_selector('tr[data-hook="admin_labels_index_rows"]')
        expect(page).to have_content 'successfully created!'
      end

    end

    context 'with errors' do

      before {create(:label, name: 'Label Test')}
      before :each do
        visit spree.new_admin_label_path
      end

      it 'must not be created if name is already taken' do
        within find('#new_label') do
          fill_in 'label[name]', with: 'Label Test'
          fill_in 'label[color]', with: '#CC0000'
          find('button[type="submit"]').click
        end
        expect(page).to have_content 'Name has already been taken'
      end

      it 'must not be created with invalid params' do
        within find('#new_label') do
          fill_in 'label[name]', with: 'Label Test2'
          find('button[type="submit"]').click
        end
        expect(page).to have_content "Color can't be blank"
      end

    end

  end

  describe 'edit' do

    let!(:label){create(:label, name: 'Label editing test')}
    let!(:label_2){create(:label, name: 'Test')}

    before :each do
      visit spree.edit_admin_label_path(label.id)
    end

    context 'without errors' do

      it 'must update the label attributes and redirect to listing with a success message' do
        within find('.edit_label') do
          fill_in 'label[name]', with: 'Name updated'
          find('button[type="submit"]').click
        end
        expect(page).to have_selector('tr[data-hook="admin_labels_index_rows"]')
        expect(page).to have_content 'successfully updated!'
      end

    end

    context 'with errors' do

      it 'must not be updated if the name is already taken' do
        within find('.edit_label') do
          fill_in 'label[name]', with: 'Test'
          find('button[type="submit"]').click
        end
        expect(label.name).to be == 'Label editing test'
        expect(page).to have_content 'Name has already been taken'
      end

      it 'must not be updated without valid parameters' do
        within find('.edit_label') do
          fill_in 'label[color]', with: ''
          find('button[type="submit"]').click
        end
        expect(label.color).not_to be == ''
        expect(page).to have_content "Color can't be blank"
      end

    end

  end

  describe 'destroy' do

    let!(:label) {create(:label)}
    let!(:variant) do
      variant = create(:variant)
      variant.labels << label
      2.times do
        l = create(:label)
        variant.labels << l
      end
      variant.save
      variant
    end

    it 'must remove the deleted label from any variants who has it' do
      visit spree.admin_labels_path
      within first('tr[data-hook="admin_labels_index_rows"]') do
        find('a[data-action="remove"]').click
      end
      expect(page).to have_content 'successfully removed!'
      expect(variant.labels.count).to be == 2
    end

  end


end