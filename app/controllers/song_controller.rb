class SongController < WebsocketRails::BaseController
  require 'soundcloud'
  attr_accessor :message_counter
  attr_accessor :client
  #@client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_ACCESS_TOKEN"])

  def initialize_session
    puts "Session Initialized\n"
    @message_counter = 0
    #@client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_ACCESS_TOKEN"])
    #track = client.get('/resolve', :url => "https://soundcloud.com/gorgon-city/sets/unmissable") 
  	#puts track
  end
  
  def client_connected
    # do something when a client connects
    puts "execuitng?"
  end
  
  def new_message
    puts "Message from UID: #{client_id}"
    #@message_counter += 1
    #puts @message_counter
    puts message[:text]
    broadcast_message :new_message, message
    #puts :new_message
  end

  def add_song
    #puts "Add song to playlist from UID: #{client_id}"
    client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_ACCESS_TOKEN"])
    track = client.get('/resolve', :url => message[:text])
    t=track.stream_url+'?client_id='+ENV["SOUNDCLOUD_ACCESS_TOKEN"]
    broadcast_message :add_song, {track: t, title: track.title}
  end
  
  def new_user
    puts "storing user in data store\n"
    data_store[:user] = message
    broadcast_user_list
  end
  
  def change_username
    data_store[:user] = message
    broadcast_user_list
  end
  
  def delete_user
    data_store.remove_client
    broadcast_message :new_message, {user_name: 'System', msg_body: "Client #{client_id} disconnected"}
    broadcast_user_list
  end
  
  def broadcast_user_list
    users = data_store.each_user
    puts "broadcasting user list: #{users}\n"
    broadcast_message :user_list, users
  end

end