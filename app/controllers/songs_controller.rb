require 'application_helper'
class SongsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :require_specific_user, :only => [:edit, :update, :destroy]
  add_crumb ("Songs"){|instance| instance.send :songs_path} 
  before_filter :interaction, :only => [:show, :edit]
  # GET /songs
  # GET /songs.xml
  def index
    @title = "Songs"
    #@songs = Song.find(:all)
    @songs = Song.paginate(:page => params[:page], :order => "created_at DESC", :conditions => {:publish => true})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show 
    @tracks = 0
    if @song.puids
      require 'rbrainz'
      @tracks = MusicBrainz::Model::Collection.new
      @song.puids.each do |puid| 
        query = MusicBrainz::Webservice::Query.new
        @tracks = @tracks + query.get_tracks(MusicBrainz::Webservice::TrackFilter.new(:puid =>puid.puid))
      end
    end
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])
    @song.user = current_user
    respond_to do |format|
      if @song.save
        flash[:notice] = 'Song was successfully created.'
        format.html { redirect_to(@song) }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    @song = Song.find(params[:id])
    if @song.audio? && params[:song]["analyze"]
      puids = analyze_audio(@song) 
      p = Array.new
      puids.each do |puid|
        p.push(Puid.new(:puid => puid))
      end
      @song.puids = p
      @song.processed = true
    end
    respond_to do |format|
      if @song.update_attributes(params[:song])
        flash[:notice] = 'Song was successfully updated.'
        format.html { redirect_to(@song) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to(songs_url) }
      format.xml  { head :ok }
    end
  end
  def fingerprint
    options = {}
    path = "/var/log/Xorg.0.log"
    options[:filename] = "test.html" 
    options[:status] = 200 
    options[:length] = File.size(path)
    options[:type] = 'text/html; charset=utf-8'
    options[:stream] = true
    options[:disposition] = "inline"
    options[:buffer_size] = 1024
    send_file_headers! options
    raise "shit"
    render :status => options[:status], :text => Proc.new { |response, output|
      len = 1024 
      File.open(path, 'rb') do |file|
        while buf = file.read(len)
          output.write(buf)
          sleep 1
        end
      end
    }
  end

  def interaction
    @song = Song.find(params[:id])
    add_crumb @song.title, @song
  end

  def require_specific_user
    unless correct_user(Song.find(params[:id]).user) || current_user.admin
      store_location
      flash[:notice] = "You are not allowed"
      redirect_to :action => :show
      #redirect_to new_user_session_url
      return false
    end
  end
  def analyze_audio(song)
    require 'earworm'
    ew = Earworm::Client.new("0736ac2cd889ef77f26f6b5e3fb8a09c")
    info = ew.identify(:file => song.audio.path)
    return info.puid_list
  end
end
