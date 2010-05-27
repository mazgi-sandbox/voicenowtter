class UsersController < ApplicationController
  before_filter :authorize, :except=>[:index, :new, :create]

  # GET /users
  # GET /users.xml
  def index
    @users = User.all(:order=>:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users.to_xml(:only => [:id, :name, :created_at, :updated_at]) }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  {
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.instruct! directive_tag=:xml, :encoding=> 'utf-8'
        render :xml => xml.user {|u|
          u.id(@user.id)
          u.name(@user.name)
          u.statuses {|ss|
            @user.statuses.each {|stat|
              ss.status {|s|
                s.id(stat.id)
                s.user_id(stat.user_id)
                s.text(stat.text)
                s.created_at(stat.created_at)
              }
            }
          }
        }
      }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    redirect_to(:action=>"index") if session[:user_id] != params[:id].to_i
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(:action=>"index") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    redirect_to(:action=>"index") if session[:user_id] != params[:id].to_i
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(:action=>"index") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    redirect_to(:action=>"index") if session[:user_id] != params[:id].to_i
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
