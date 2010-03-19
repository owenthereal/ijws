class Text2speech
  include MongoMapper::Document
  include Grip
  include GeoLocation
  include GoogleSpeechService
  include BaseXHash
  
  key :text, String, :required => true, :allow_blank => false
  key :created_at, Time, :index => true
  
  has_grid_attachment :speech
  has_geo_location :geo
  has_id :uid
  
  validate :valid_text?
  
  before_create :trim_extra_spaces
  before_save :create_timestamps, :fill_uid
  
  def generate_default_speech
    self.speech = retrive_google_speech(self.text)
  end
  
  def self.find_via_hash(hash)
     id = BaseCoder::decode(hash)
     all(:uid=> id).first
   end
  
  private 
  
  def valid_text?
    unless self.text.length <= 100
      errors.add(:text, "must have at most 100 words.")
    end
  end
  
  def trim_extra_spaces
    self.text = self.text.trim_extra_space.strip
  end
  
  def create_timestamps
    self[:created_at] ||= Time.now.utc
  end
  
  def fill_uid
    self[:uid] = self[:_id].hash
  end
end

