class AddTitleToGramModel < ActiveRecord::Migration[5.1]
  def change
    add_column :grams, :title, :string
  end
end
