require File.dirname(__FILE__) + '/../test_helper'
require 'uketsuke_rirekis_controller'

# Re-raise errors caught by the controller.
class UketsukeRirekisController; def rescue_action(e) raise e end; end

class UketsukeRirekisControllerTest < Test::Unit::TestCase
  fixtures :uketsuke_rirekis

  def setup
    @controller = UketsukeRirekisController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = uketsuke_rirekis(:first).id
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

    assert_not_nil assigns(:uketsuke_rirekis)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:uketsuke_rireki)
    assert assigns(:uketsuke_rireki).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:uketsuke_rireki)
  end

  def test_create
    num_uketsuke_rirekis = UketsukeRireki.count

    post :create, :uketsuke_rireki => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_uketsuke_rirekis + 1, UketsukeRireki.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:uketsuke_rireki)
    assert assigns(:uketsuke_rireki).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      UketsukeRireki.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      UketsukeRireki.find(@first_id)
    }
  end
end
