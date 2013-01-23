class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.string :title
      t.string :url
      t.text :content
      t.text :rendered_content
      t.string :theme, default: '#B82010'
      t.text :css
      t.integer :messages_count
      t.integer :topics_count
      t.integer :users_count

      t.timestamps
    end
    add_index :domains, :name
  end
end
