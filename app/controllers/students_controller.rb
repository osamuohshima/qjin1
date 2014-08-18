require 'application.rb'
class StudentsController < ApplicationController
 require 'jcode' 
# before_filter :to_zenkaku_alpher
  def index
       
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @student_pages, @students = paginate :students, :per_page => 25
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new
		@student.sex = 1
		@student.group_id =3
    @student.nyugakuid = @student.nyugakuid.tr( 'Ａ-Ｚ','A-Z' ).tr( 'ａ-ｚ','A-Z' )
    @student.nyugakuid = @student.nyugakuid.tr( '０-９','0-9' ).tr( '．','.' )
		if @student.ka =''
		  @student.ka = nyugakuid2ka
		end	
	  @student_nenji = StudentNenji.new
		@student.student_nenji = @student_nenji
 #   @student_nenji.student_id = @student.id
    redirect_to :controller => 'student_nenji', :action => 'new'
    if @student.save
      flash[:notice] = '生徒ユーザは新規作成されました。'
			if @student_nenji.save
				flash[:notice] = '生徒年次データは新規に作成されました'
			end
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
		if @student.ka =''
		  @student.ka = nyugakuid2ka
		end
    if @student.update_attributes(params[:student])
      flash[:notice] = '生徒ユーザは新規作成されました。'
      redirect_to :action => 'show', :id => @student
    else
      render :action => 'edit'
    end
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

	def nenji
		begin
		  nendo_in = nendo()
      @student = Student.find(params[:id])
		  @nenji = @student.student_nenjis.find(params[:id])
   rescue
			@nenji = @student.student_nenjis.new( :student_id => @student.id)
	 end
		render :action => 'nenji'
	end

	def nyugakuid2ka
    @ka = @student.nyugakuid[2,1]
		case @ka
		  when "M" then ka=1
			when "E" then ka=2
			when "C" then ka=3
			when "A" then ka=4
			when "I" then ka=5
		end
		return ka
	end

	def show_pdf

	end

	private
  def to_zenkaku_alpher(str)
    hanalph2zenalph(str)	
  end		

end
