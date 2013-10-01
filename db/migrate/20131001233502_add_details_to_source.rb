class AddDetailsToSource < ActiveRecord::Migration
  def change
    add_column :sources, :url, :string
  end
end
