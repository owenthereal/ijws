require 'grip'

class Speech
  include MongoMapper::Document
  include Grip
  
  key :text, String, :required => true, :allow_blank => false
  key :created_date, Time, :required => true
  key :remote_ip, String, :required => true
  
  has_grid_attachment :voice
end
