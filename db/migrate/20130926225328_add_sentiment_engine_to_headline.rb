class AddSentimentEngineToHeadline < ActiveRecord::Migration
  def change
    add_column :headlines, :sentiment_engine, :string
  end
end
