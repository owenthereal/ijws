require 'open-uri'
require 'tempfile'

module SpeechesHelper
  def google_speech_url(text)
     "http://translate.google.com/translate_tts?tl=en&q=#{text.gsub(/\s+/, '+')}"
  end
  
  def google_speech(url)
    voice = open(url)
    temp_file = Tempfile.new('test.mp3')
    temp_file.write(voice.read)
    temp_file.flush
  end
  
  def embed_tag(src, options = {})
    tag :embed, { "src" => src }.update(options.stringify_keys)
  end
  
  def voice_path_for(speech)
    "voice/#{speech.id}"
  end
end
