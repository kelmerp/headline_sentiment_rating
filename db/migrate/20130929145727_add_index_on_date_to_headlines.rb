class AddIndexOnDateToHeadlines < ActiveRecord::Migration
  def change
    add_index :headlines, :date
  end
end
