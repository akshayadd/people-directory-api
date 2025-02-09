class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :person

      t.string :street,      null: false
      t.string :landmark
      t.string :city,        null: false
      t.string :state,       null: false
      t.string :country,     null: false
      t.string :postal_code, null: false
      t.boolean :is_primary, default: false

      t.timestamps
    end
  end
end
