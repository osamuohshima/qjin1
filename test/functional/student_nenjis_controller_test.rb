require File.dirname(__FILE__) + '/../test_helper'
require 'student_nenjis_controller'

# Re-raise errors caught by the controller.
class StudentNenjisController; def rescue_action(e) raise e end; end

class StudentNenjisControllerTest < Test::Unit::TestCase
  fixtures :student_nenjis

  def setup
    @controller = StudentNenjisController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = student_nenjis(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:student_nenjis)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:student_nenjis)
    assert assigns(:student_nenjis).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:student_nenjis)
  end

  def test_create
    num_student_nenjis = StudentNenjis.count

    post :create, :student_nenjis => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_student_nenjis + 1, StudentNenjis.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:student_nenjis)
    assert assigns(:student_nenjis).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      StudentNenjis.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      StudentNenjis.find(@first_id)
    }
  end
end
