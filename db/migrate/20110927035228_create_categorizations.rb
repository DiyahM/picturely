class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.integer :picture_id
      t.integer :keyword_id

      t.timestamps
    end
    add_index :picture_id
    add_index :keyword_id
  end

  def self.down
    drop_table :categorizations
  end
end
