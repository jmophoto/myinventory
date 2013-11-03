# encoding: utf-8
class OldInspectionRooms < ActiveRecord::Base

  establish_connection(
    adapter:  "mysql2",
    host:     "localhost",
    username: "root",
    password: "",
    database: "old_inspeckd"
  )

  self.table_name  = "tbl_inspection_rooms"
  self.primary_key = "inrm_id"
end