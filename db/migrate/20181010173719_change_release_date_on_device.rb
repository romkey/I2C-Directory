class ChangeReleaseDateOnDevice < ActiveRecord::Migration[5.2]
  def change
    remove_column :devices, :release_date
    add_column :devices, :release_date, :integer, null: true, min: 1982, max: 2050    
  end
end
