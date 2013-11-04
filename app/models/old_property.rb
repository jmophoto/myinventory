# encoding: utf-8
class OldProperty < ActiveRecord::Base

  establish_connection(
    adapter:  "mysql2",
    host:     "localhost",
    username: "root",
    password: "",
    database: "old_inspeckd"
  )

  self.table_name  = "tbl_property_master"
  self.primary_key = "prms_id"
  
  def import
    Property.create!(
      legacy_id: self.prms_id,
      name: self.prms_title,
      address: self.prms_address,
      city: self.prms_city,
      state: self.prms_state,
      zip: self.prms_zip
    )
  end
end