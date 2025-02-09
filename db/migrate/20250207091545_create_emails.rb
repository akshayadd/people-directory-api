class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.references :person

      t.string  :email
      t.boolean :is_primary, default: false

      t.timestamps
    end
  end
end
