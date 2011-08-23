class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.string :term

      t.timestamps
    end

    add_index :queries, :term
  end

  def self.down
    remove_index :queries, :term

    drop_table :queries
  end
end
