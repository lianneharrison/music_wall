class AddForeignKeyToSongs < ActiveRecord::Migration

  change_table(:songs) do |t|
  t.references :user
  end
  
end
