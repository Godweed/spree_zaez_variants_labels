FactoryGirl.define do


  factory :label, class: Spree::Label do

    colors = ['#5bb85b', '#777777', '#337ab7', '#d9534f']

    sequence(:name) {|n| "Label-#{n}"}
    color colors[Random.rand(0..3)]

  end

end
