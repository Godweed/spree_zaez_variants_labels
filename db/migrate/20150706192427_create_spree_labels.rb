class CreateSpreeLabels < ActiveRecord::Migration
  def change
    create_table :spree_labels do |t|
      t.string :name
      t.string :color
    end
  end
end
