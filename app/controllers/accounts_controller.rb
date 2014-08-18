class AccountsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end

	def students_index
	  redirect_to(:action => 'signup') unless logged_in? || User.count > 0
	end

	def teachers_index
	  redirect_to(:action => 'signup') unless logged_in? || User.count > 0
	end

  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
			redirect_to
			case User.find_by_login(:login).group_id
			  when 1 then
          redirect_back_or_default(:controller => '/accounts', :action => 'admins_index')
          flash[:notice] = "ログインに成功しました"
				when 2 then
          redirect_back_or_default(:controller => '/accounts', :action => 'teaches_index')
          flash[:notice] = "ログインに成功しました"
				when 3 then
          redirect_back_or_default(:controller => '/accounst', :action => 'students_index')
          flash[:notice] = "ログインに成功しました"
 				else
				  index
			end
    end
  end

  def signup
    @user = User.new(params[:user])
		@user.group_id = 2
    return unless request.post?
    @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/accounts', :action => 'index')
    flash[:notice] = "登録成功"
		sleep(2)
#		if @user.group_id = 3
#		  redirect_to :controller => 'students', :action => 'new', :student_id => @user.id
#		  return
#		else 
#			redirect_to :controller => 'teachers', :action => 'new', :teacher_id => @user.id
 #     return
#		end
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "ログアウト完了"
    redirect_back_or_default(:controller => '/accounts', :action => 'index')
  end
end
