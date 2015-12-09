class AddAlphabetizeChildPages < ActiveRecord::Migration
  def self.up
    add_column :refinery_pages, :alphabetize_child_pages, :boolean
  end

  def self.down
    remove_column :refinery_pages, :alphabetize_child_pages
  end
end