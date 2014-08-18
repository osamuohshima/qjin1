class StudentNenjisController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @student_nenjis_pages, @student_nenjis = paginate :student_nenjis, :per_page => 10
  end

  def show
    @student_nenjis = StudentNenji.find(params[:id])
  end

  def new
    @student_nenjis = StudentNenji.new
		@student_nenjis.nendo = Time.now.year
  end

  def create
    @student_nenjis = StudentNenji.new(params[:student_nenjis])
    if @student_nenjis.save
      flash[:notice] = 'StudentNenjis was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @student_nenjis = StudentNenji.find(params[:id])
  end

  def update
    @student_nenjis = StudentNenji.find(params[:id])
    if @student_nenjis.update_attributes(params[:student_nenjis])
      flash[:notice] = '生徒の年次データの更新に成功しました'
      redirect_to :action => 'show', :id => @student_nenjis
    else
      render :action => 'edit'
    end
  end

  def destroy
    StudentNenji.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
