class CreateCampers < ActiveRecord::Migration[6.1]
  def change
    create_table :campers do |t|
      t.string :name, null: false
      t.belongs_to :campsite, null: false

      t.timestamps null: false
    end
  end
end
