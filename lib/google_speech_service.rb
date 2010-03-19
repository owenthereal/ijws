module GoogleSpeechService
  def retrive_google_speech(text)
    url = "http://translate.google.com/translate_tts?tl=en&q=#{text.gsub(/\s+/, '+')}"
    open(url)
  end
end