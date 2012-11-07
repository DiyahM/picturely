class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.integer :picture_id
      t.integer :keyword_id

      t.timestamps
    end
    add_index :categorizations, :picture_id
    add_index :categorizations, :keyword_id
  end

  def self.down
    drop_table :categorizations
  end
end
