class AddUniqueIndexOnSentimentData < ActiveRecord::Migration
  def change
    add_index :sentiment_data, [:headline_id, :sentiment_engine], :unique => true
  end
end
