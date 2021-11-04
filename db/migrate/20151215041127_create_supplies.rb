class CreateSupplies < ActiveRecord::Migration[6.1]
  def change
    create_table :supplies do |t|
      t.string :name, null: false
      t.belongs_to :camper, null: false

      t.timestamps null: false
    end
  end
end
