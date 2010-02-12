class SpeechesController < ApplicationController
  def show
    @speech = Speech.find(params[:id])
  end
  
  def voice
     @speech = Speech.find(params[:id])
     send_data @speech.voice, :type => @speech.voice_content_type, :filename => @speech.voice_path, :disposition => 'inline'
  end
  
  def new
    @speech = Speech.new
  end
  
  def google_speech(text)
    url = "http://translate.google.com/translate_tts?tl=en&q=#{text.gsub(/\s+/, '+')}"
    open(url) 
  end
  
  def create
    @speech = Speech.new(params[:speech])
    @speech.created_date = Time.new
    @speech.remote_ip = request.remote_ip
    @speech.voice = google_speech(@speech.text)
    
    if @speech.save
      flash[:notice] = "Successfully created speech."
      redirect_to "/#{@speech.id}"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @speech = Speech.find(params[:id])
  end
  
  def update
    @speech = Speech.find(params[:id])
    if @speech.update_attributes(params[:speech])
      flash[:notice] = "Successfully updated speech."
      redirect_to "/#{@speech.id}"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @speech = Speech.find(params[:id])
    @speech.destroy
    flash[:notice] = "Successfully destroyed speech."
    redirect_to speeches_url
  end
end
