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
end