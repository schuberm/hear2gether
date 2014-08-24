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
    #@listener=Listener.find(session[:current_listener_id])
    #if Listener.exists?(dj: true)
    if session[:current_listener_id]==nil
      @listener=Listener.create(dj: false)
      session[:current_listener_id] = @listener.id
    elsif Listener.find(session[:current_listener_id]).dj==true
      @listener = Listener.where(:dj => true).first
    end

  end

  def eventtracker
    #@listener = Listener.find(params[:id])
    #@listener = Listener.where(:dj => true).first
    @listener = Listener.find(session[:current_listener_id])
    if @listener == nil
      render :nothing =>  true
    elsif @listener.dj==true
      @channel=Channel.find(params[:id])
      @data = request.filtered_parameters
      #puts @data
      #puts @data['currentPosition']
      @channel.update(currentPosition: @data['currentPosition'])
      #puts @channel.currentPosition
      render :nothing =>  true
    end
  end

  def sendChannelToDj
    @channel = Channel.find(params[:id])
    respond_to do |format|
        format.html
        format.json { render :json => @channel}
    end
  end

  def sendListenerToDj
    #@channel = Channel.find(params[:id])
    @listener = Listener.find(session[:current_listener_id])
    #@listener = Listener.find(params[:id])
    respond_to do |format|
        format.html
        format.json { render :json => @listener}
    end
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
    session[:current_listener_id] = @listener.id
    #gon.dj= @listener.dj

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
      params[:channel].permit(:querysc,:currentPosition)
    end
end
