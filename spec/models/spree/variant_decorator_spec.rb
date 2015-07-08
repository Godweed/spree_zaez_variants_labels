require 'spec_helper'

RSpec.describe Spree::Variant, type: :model do

  let(:variant) { create(:variant)}

  it{is_expected.to have_and_belong_to_many(:labels)}

end