class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  require 'soundcloud'

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.all
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    @channel=Channel.find(params[:id])
    #@listener=Listener.create
    #@listener = Listener.where(:dj => true).first
    if Listener.exists?(dj: true)
      @listener = Listener.where(:dj => true).first
      gon.dj= @listener.dj
      puts gon.dj
    else
      @listener=Listener.create
      @listener.dj = false
      gon.dj= @listener.dj
      puts gon.dj
    end
    
    #sc_client = Soundcloud.new(:client_id  => ENV["SOUNDCLOUD_ACCESS_TOKEN"])
    # get a tracks oembed data
    #track_url = 'http://soundcloud.com/forss/flickermood'
    #track_url ='https://w.soundcloud.com/player/?url=http://api.soundcloud.com/users/1539950/favorites'
    #embed_info = sc_client.get('/oembed', :url => track_url)

    #@sc_player = embed_info['html']
    #sc_query_raw = sc_client.get('/tracks', :q => @channel.querysc)
    #puts sc_query_raw
    #@sc_query = []
    #sc_query_raw.each do |track|
    #  if track.embeddable_by =='all'
        #sc_query_embed = sc_client.get('/oembed', :url => track.permalink_url)
        #@sc_query << sc_query_embed['html']
    #  end
    #end

  end

  def eventtracker
    #@listener = Listener.find(params[:id])
    @listener = Listener.where(:dj => true).first
    #puts @listener
    #if @listener.dj == true
    #if @listener == nil
    #  render :nothing =>  true
    #else
      @data = request.filtered_parameters
      puts @data
      #puts @data['currentPosition']
      #puts @data['state']
      #render :text =>  @data['currentPosition']
      render :nothing =>  true
    #end
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
    @listener = Listener.create(dj: true)
    gon.dj= @listener.dj
    puts gon.dj

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params[:channel].permit(:querysc)
    end
end
