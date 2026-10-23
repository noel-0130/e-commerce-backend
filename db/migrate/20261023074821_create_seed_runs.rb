class CreateSeedRuns < ActiveRecord::Migration[8.1]
  def change
    create_table :seed_runs do |t|
      t.string :seed_name, null: false
      t.timestamps
    end

    add_index :seed_runs, :seed_name, unique: true
  end
end