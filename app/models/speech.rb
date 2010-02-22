require 'grip'

class Speech
  include MongoMapper::Document
  include Grip
  
  key :text, String, :required => true, :allow_blank => false
  key :created_date, Time, :required => true
  key :remote_ip, String, :required => true
  
  has_grid_attachment :voice
  
  validate :valid_text?
  
  private 
  
  def valid_text?
    unless self.text.gsub(/\s+/, ' ').length <= 100
      errors.add(:text, "must have at most 100 words.")
    end
  end
  
end
