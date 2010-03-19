require 'test_helper'

class Text2speechesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Speech.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Speech.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Speech.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to speech_url(assigns(:speech))
  end
  
  def test_edit
    get :edit, :id => Speech.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Speech.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Speech.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Speech.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Speech.first
    assert_redirected_to speech_url(assigns(:speech))
  end
  
  def test_destroy
    speech = Speech.first
    delete :destroy, :id => speech
    assert_redirected_to speeches_url
    assert !Speech.exists?(speech.id)
  end
end
