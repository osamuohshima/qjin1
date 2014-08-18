require File.dirname(__FILE__) + '/../test_helper'
require 'kyujin_daicho_t1s_controller'

# Re-raise errors caught by the controller.
class KyujinDaichoT1sController; def rescue_action(e) raise e end; end

class KyujinDaichoT1sControllerTest < Test::Unit::TestCase
  fixtures :kyujin_daicho_t1s

  def setup
    @controller = KyujinDaichoT1sController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = kyujin_daicho_t1s(:first).id
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

    assert_not_nil assigns(:kyujin_daicho_t1s)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:kyujin_daicho_t1s)
    assert assigns(:kyujin_daicho_t1s).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:kyujin_daicho_t1s)
  end

  def test_create
    num_kyujin_daicho_t1s = KyujinDaichoT1s.count

    post :create, :kyujin_daicho_t1s => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_kyujin_daicho_t1s + 1, KyujinDaichoT1s.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:kyujin_daicho_t1s)
    assert assigns(:kyujin_daicho_t1s).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      KyujinDaichoT1s.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      KyujinDaichoT1s.find(@first_id)
    }
  end
end
