Spree::Variant.class_eval do

  has_and_belongs_to_many :labels, class_name: 'Spree::Label'

end