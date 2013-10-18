class AddReportDateToInspection < ActiveRecord::Migration
  def change
    add_column :inspections, :report_date, :date
  end
end
