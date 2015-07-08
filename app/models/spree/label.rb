class Spree::Label < Spree::Base

  has_and_belongs_to_many :variants, class_name: 'Spree::Variant'

  validates_presence_of :name, :color
  validates_uniqueness_of :name

end