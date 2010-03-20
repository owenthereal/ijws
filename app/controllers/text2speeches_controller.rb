class Text2speechesController < ApplicationController 
  def index
    redirect_to root_path
  end
  
  def show
    @text2speech = Text2speech.find_via_hash(params[:hash]) 
  end
  
  def speech
     @text2speech = Text2speech.find(params[:id])
     @text2speech.generate_default_speech if @text2speech.speech_path.nil?
     send_data @text2speech.speech, :type => @text2speech.speech_content_type, :filename => @text2speech.speech_path, :disposition => 'inline'
  end
  
  def new
    @text2speech = Text2speech.new
  end
  
  def say
    puts request.query_string
  end
  
  def create
    @text2speech = Text2speech.new(params[:text2speech])
    @text2speech.geo_ip = request.remote_ip
     
    if @text2speech.save
      flash[:notice] = "Successfully created speech."
      redirect_to "/#{@text2speech.uid_hash}"
    else
      render :action => 'new'
    end
  end
  
  private
  
  # def load_speech_timeline
  #    @speech_timeline = Speech.all(:order => 'created_date desc', :limit => 5)
  #  end
  
  # def edit
  #    @speech = Speech.find(params[:id])
  #  end
  #  
  #  def update
  #    @speech = Speech.find(params[:id])
  #    if @speech.update_attributes(params[:speech])
  #      flash[:notice] = "Successfully updated speech."
  #      redirect_to "/#{@speech.id}"
  #    else
  #      render :action => 'edit'
  #    end
  #  end
  #  
  #  def destroy
  #    @speech = Speech.find(params[:id])
  #    @speech.destroy
  #    flash[:notice] = "Successfully destroyed speech."
  #    redirect_to speeches_url
  #  end
end
