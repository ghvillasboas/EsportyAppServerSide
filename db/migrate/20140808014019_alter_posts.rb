class AlterPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :data_hora, :datetime
  	add_column :posts, :autor, :string
  	add_column :posts, :token, :string
  	add_column :posts, :comments, :text
  	add_column :posts, :imagem, :string
  end
end
