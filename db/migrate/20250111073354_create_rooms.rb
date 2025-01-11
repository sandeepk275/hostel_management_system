class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.references :hostel, null: false, foreign_key: { on_delete: :cascade }
      t.string :room_number, null: false
      t.integer :capacity, null: false
      t.decimal :price_per_bed, precision: 10, scale: 2, null: false
      t.boolean :is_available, default: true
      t.timestamps
    end
  end
end
