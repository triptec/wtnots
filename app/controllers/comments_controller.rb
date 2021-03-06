class CommentsController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :update, :create]
  # GET /comments
  # GET /comments.xml
  def reply
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
      format.js {render :partial => "new_reply"}
    end 
  end
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.song = Song.find(params[:song_id])
    respond_to do |format|
      if @comment.save
        if(params[:comment_id])
          Replyship.create!(:comment_id => params[:comment_id], :reply_id => @comment.id)
          flash[:notice] = 'Reply was successfully created.'
          format.html { redirect_to(@comment.song) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
          format.js {render "create_reply"}
        else
          flash[:notice] = 'Comment was successfully created.'
          format.html { redirect_to(@comment.song) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
          format.js {render "create_comment"}
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(song_url(@comment.song_id)) }
      format.xml  { head :ok }
    end
  end
end
