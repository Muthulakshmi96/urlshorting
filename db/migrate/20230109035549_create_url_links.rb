class CreateUrlLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :url_links do |t|
      t.string :url
      t.string :slug
      t.integer :clicked, default: 0

      t.timestamps
    end
  end
end
