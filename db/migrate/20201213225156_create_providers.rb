class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :bio
      t.belongs_to :user
    end
  end
end
