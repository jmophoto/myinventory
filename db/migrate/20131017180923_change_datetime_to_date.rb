class ChangeDatetimeToDate < ActiveRecord::Migration
  def self.up
   change_column :inspections, :inspection_date, :date
  end

  def self.down
   change_column :inspections, :inspection_date, :datetime
  end
end
