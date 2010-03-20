require 'open-uri'

module Text2speechesHelper
  def embed_tag(src, options = {})
    tag :embed, { "src" => src }.update(options.stringify_keys)
  end

  def speech_url_for(text2speech)
    "/text2speeches/speech/#{text2speech.id}"
  end

  def recent_text2speeches()
    Text2speech.all(:order => 'created_at desc', :limit => 6)
  end

  def text2speech_url(text2speech)
    URI::HTTP.build(:host => request.host, :port => request.port, :path => "/#{text2speech.uid_hash}").to_s
  end
  
  def share_content(text2speech)
    "I just wanna say..." + text2speech_url(text2speech)
  end

  def trim_text(text, number_of_words)
    all_words = text.words
    if all_words.size <= number_of_words 
      text
    else
      reg_exp = all_words[0..(number_of_words-1)].join('\W*')
      text.match(/#{reg_exp}/)[0] + '...'
    end
  end
  
  def geo_location(text2speech)
    if text2speech.geo_address.nil?
      ""
    else
      "from " + text2speech.geo_address
    end
  end
end

class String
  def trim_extra_space
    gsub(/\s+/, ' ')
  end

  def words
    scan(/\w[\w\'\-']*/)
  end
end
