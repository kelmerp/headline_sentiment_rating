class CreateSentimentData < ActiveRecord::Migration
  def change
    create_table :sentiment_data do |t|
      t.decimal :sentiment_score
      t.string :sentiment_description
      t.string :sentiment_engine
      t.belongs_to :headline

      t.timestamps
    end

    add_index :sentiment_data, :sentiment_score
    add_index :sentiment_data, :sentiment_description
    add_index :sentiment_data, :sentiment_engine
  end
end
