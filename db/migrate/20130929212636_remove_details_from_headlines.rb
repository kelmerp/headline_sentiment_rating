class RemoveDetailsFromHeadlines < ActiveRecord::Migration
  def change
    change_table :headlines do |t|
      t.remove :sentiment_score
      t.remove :sentiment_description
      t.remove :sentiment_engine
      # t.remove_index :sentiment_score
      # t.remove_index :sentiment_description
      # t.remove_index :sentiment_engine
    end
  end
end
