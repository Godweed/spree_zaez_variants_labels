require 'spec_helper'

RSpec.describe Spree::Label, type: :model do

  let(:label) { create(:label) }

  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_uniqueness_of(:name)}
  it {is_expected.to validate_presence_of(:color)}
  it {is_expected.to have_and_belong_to_many(:variants)}

  it 'must have a valid factory' do
    expect(build(:label)).to be_valid
  end

end