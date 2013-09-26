class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
      t.datetime :date
      t.string :content
      t.decimal :sentiment_score
      t.string :sentiment_description
      t.string :archive_url
      t.belongs_to :source

      t.timestamps
    end

    add_index :headlines, :sentiment_score
    add_index :headlines, :sentiment_description
    add_index :headlines, :content
  end
end
