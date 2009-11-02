require 'test_helper'

class AdvicesControllerTest < ActionController::TestCase
  fixtures :all
    
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advices)
  end

  test "should not get new" do
    get :new
    assert_response :redirect
  end

  test "should get new" do
    login_as :quentin
    get :new
    assert_response :success
  end

  test "should not create advice" do
    assert_no_difference('Advice.count') do
      post :create, :advice => { }
    end
  end
  
  test "should create advice" do
    login_as :quentin
    assert_difference('Advice.count') do
      post :create, :advice => {:title => 'Name', :description => 'Desc' }
    end
    assert_redirected_to advice_path(assigns(:advice))
  end
  
  test "should not create advice without title" do
    login_as :quentin
    assert_no_difference('Advice.count') do
      post :create, :advice => { }
    end
  end

  test "should show advice" do
    get :show, :id => advices(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as :quentin
    get :edit, :id => advices(:one).id
    assert_response :success
  end

  test "should not get edit of other advice" do
    login_as :aaron
    get :edit, :id => advices(:one).id
    assert_response :redirect
  end
  
  test "should not get edit" do
    get :edit, :id => advices(:one).id
    assert_response :redirect
  end
  
  test "should update advice" do
    login_as :quentin
    put :update, :id => advices(:one).id, :advice => { }
    assert_redirected_to advice_path(assigns(:advice))
  end

  test "should not update of other advice" do
    login_as :aaron
    put :update, :id => advices(:one).id, :advice => { }
    assert_redirected_to '/'
  end

  test "should destroy advice" do
    login_as :quentin
    assert_difference('Advice.count', -1) do
      delete :destroy, :id => advices(:one).id
    end

    assert_redirected_to advices_path
  end

  test "should not destroy advice" do
    assert_no_difference 'Advice.count' do
      delete :destroy, :id => advices(:one).id
    end
    assert_redirected_to '/'
    login_as :aaron
    assert_no_difference 'Advice.count' do
      delete :destroy, :id => advices(:one).id
    end
    assert_redirected_to '/'
  end
  
end
