class StatusesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  # GET /statuses
  # GET /statuses.xml
  def index
    @user = User.find(session[:user_id])
    @statuses = @user.statuses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])
    @user = User.find(@status.user_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])
    @status.user_id = session[:user_id]

    respond_to do |format|
      if @status.save
        flash[:notice] = 'Status was successfully created.'
        #format.html { redirect_to(@status) }
        format.html { redirect_to(:controller => "users", :action => @status.user_id) }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      #format.html { redirect_to(statuses_url) }
      format.html { redirect_to(:controller => "users", :action => @status.user_id) }
      format.xml  { head :ok }
    end
  end
end
