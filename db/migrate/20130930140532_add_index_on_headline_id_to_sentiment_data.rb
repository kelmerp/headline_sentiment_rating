class AddIndexOnHeadlineIdToSentimentData < ActiveRecord::Migration
  def change
    add_index :sentiment_data, :headline_id
  end
end
