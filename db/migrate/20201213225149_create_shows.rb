class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.belongs_to :provider
      t.string :name
      t.string :description
      t.string :run_time
    end
  end
end
