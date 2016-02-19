class CreateBowls < ActiveRecord::Migration
  def change
    create_table :bowls do |t|
      t.references :person, index: true, foreign_key: true
      t.integer :chips

      t.timestamps null: false
    end
  end
end
