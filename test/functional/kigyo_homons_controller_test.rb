require File.dirname(__FILE__) + '/../test_helper'
require 'kigyo_homons_controller'

# Re-raise errors caught by the controller.
class KigyoHomonsController; def rescue_action(e) raise e end; end

class KigyoHomonsControllerTest < Test::Unit::TestCase
  fixtures :kigyo_homons

  def setup
    @controller = KigyoHomonsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = kigyo_homons(:first).id
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

    assert_not_nil assigns(:kigyo_homons)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:kigyo_homon)
    assert assigns(:kigyo_homon).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:kigyo_homon)
  end

  def test_create
    num_kigyo_homons = KigyoHomon.count

    post :create, :kigyo_homon => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_kigyo_homons + 1, KigyoHomon.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:kigyo_homon)
    assert assigns(:kigyo_homon).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      KigyoHomon.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      KigyoHomon.find(@first_id)
    }
  end
end
