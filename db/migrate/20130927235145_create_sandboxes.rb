class CreateSandboxes < ActiveRecord::Migration
  def change
    create_table :sandboxes do |t|

      t.timestamps
    end
  end
end
