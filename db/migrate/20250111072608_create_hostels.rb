class CreateHostels < ActiveRecord::Migration[7.1]
  def change
    create_table :hostels do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description
      t.string :contact_number
      t.string :email
      t.timestamps
    end
  end
end
