# encoding: utf-8
class OldLead < ActiveRecord::Base

  establish_connection(
    adapter:  "mysql2",
    host:     "localhost",
    username: "root",
    password: "",
    database: "old_inspeckd"
  )

  self.table_name  = "tbl_lead_master"
  self.primary_key = "lead_id"
end