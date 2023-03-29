class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.date :start_date
      t.date :end_date
      t.references :home, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
