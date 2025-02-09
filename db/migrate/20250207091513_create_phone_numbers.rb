class CreatePhoneNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :phone_numbers do |t|
      t.references :person

      t.string :mobile_number, null: false
      t.boolean :is_primary, default: false

      t.timestamps
    end
  end
end
