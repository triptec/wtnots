class ReplyshipsController < ApplicationController
  # GET /replyships
  # GET /replyships.xml
  def index
    @replyships = Replyship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replyships }
    end
  end

  # GET /replyships/1
  # GET /replyships/1.xml
  def show
    @replyship = Replyship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @replyship }
    end
  end

  # GET /replyships/new
  # GET /replyships/new.xml
  def new
    #@replyship = Replyship.new
		@replyship = Comment.find(params[:comment_id]).replyships.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @replyship }
    end
  end

  # GET /replyships/1/edit
  def edit
    @replyship = Replyship.find(params[:id])
  end

  # POST /replyships
  # POST /replyships.xml
  def create
    @replyship = Replyship.new(params[:replyship])

    respond_to do |format|
      if @replyship.save
        flash[:notice] = 'Replyship was successfully created.'
        format.html { redirect_to(@replyship) }
        format.xml  { render :xml => @replyship, :status => :created, :location => @replyship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @replyship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replyships/1
  # PUT /replyships/1.xml
  def update
    @replyship = Replyship.find(params[:id])

    respond_to do |format|
      if @replyship.update_attributes(params[:replyship])
        flash[:notice] = 'Replyship was successfully updated.'
        format.html { redirect_to(@replyship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @replyship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replyships/1
  # DELETE /replyships/1.xml
  def destroy
    @replyship = Replyship.find(params[:id])
    @replyship.destroy

    respond_to do |format|
      format.html { redirect_to(replyships_url) }
      format.xml  { head :ok }
    end
  end
end
