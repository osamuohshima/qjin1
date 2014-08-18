require File.dirname(__FILE__) + '/../test_helper'
require 'kyujin_uketsukes_controller'

# Re-raise errors caught by the controller.
class KyujinUketsukesController; def rescue_action(e) raise e end; end

class KyujinUketsukesControllerTest < Test::Unit::TestCase
  fixtures :kyujin_uketsukes

  def setup
    @controller = KyujinUketsukesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = kyujin_uketsukes(:first).id
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

    assert_not_nil assigns(:kyujin_uketsukes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:kyujin_uketsuke)
    assert assigns(:kyujin_uketsuke).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:kyujin_uketsuke)
  end

  def test_create
    num_kyujin_uketsukes = KyujinUketsuke.count

    post :create, :kyujin_uketsuke => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_kyujin_uketsukes + 1, KyujinUketsuke.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:kyujin_uketsuke)
    assert assigns(:kyujin_uketsuke).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      KyujinUketsuke.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      KyujinUketsuke.find(@first_id)
    }
  end
end
