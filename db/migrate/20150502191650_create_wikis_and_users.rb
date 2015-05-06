class CreateWikisAndUsers < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :user_id
      t.integer :wiki_id
      t.timestamps
    end

    add_index :users, :id, unique: true
    add_index :wikis, :id, unique: true
  end
end
