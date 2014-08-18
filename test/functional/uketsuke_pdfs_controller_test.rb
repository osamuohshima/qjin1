require File.dirname(__FILE__) + '/../test_helper'
require 'uketsuke_pdfs_controller'

# Re-raise errors caught by the controller.
class UketsukePdfsController; def rescue_action(e) raise e end; end

class UketsukePdfsControllerTest < Test::Unit::TestCase
  fixtures :uketsuke_pdfs

  def setup
    @controller = UketsukePdfsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = uketsuke_pdfs(:first).id
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

    assert_not_nil assigns(:uketsuke_pdfs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:uketsuke_pdfs)
    assert assigns(:uketsuke_pdfs).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:uketsuke_pdfs)
  end

  def test_create
    num_uketsuke_pdfs = UketsukePdfs.count

    post :create, :uketsuke_pdfs => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_uketsuke_pdfs + 1, UketsukePdfs.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:uketsuke_pdfs)
    assert assigns(:uketsuke_pdfs).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      UketsukePdfs.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      UketsukePdfs.find(@first_id)
    }
  end
end
