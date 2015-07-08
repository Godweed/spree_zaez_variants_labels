class CreateSpreeLabelsVariants < ActiveRecord::Migration
  def change
    create_table :spree_labels_variants, :id => false do |t|
      t.references :label
      t.references :variant
    end
  end
end
