class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.timestamps
    end
  end
end
