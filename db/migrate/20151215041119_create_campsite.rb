class CreateCampsite < ActiveRecord::Migration[6.1]
  def change
    create_table :campsites do |t|
      t.string :name, null: false
      
      t.timestamps null: false
    end
  end
end
