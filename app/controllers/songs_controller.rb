class SongsController < ApplicationController
  # index
  def index
    @songs = Song.all
  end

  # new
  def new
    @artist = Artist.find(params[:artist_id])
    @song = Song.new
  end

  # create
  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new(song_params)
    if @song.save
      flash[:notice] = "#{@song.title} was successfully created."
      redirect_to @song
    else
      render :new
    end
  end

  #show
  def show
    @song = Song.find(params[:id])
    @artist = @song.artist
  end

  # edit
  def edit
    @song = Song.find(params[:id])
    @artist = @song.artist
  end

  # update
  def update
    @song = Song.find(params[:id])
    @artist = @song.artist
    if @song.update(song_params)
      flash[:notice] = "#{@song.title} was successfully updated."
      redirect_to @song
    else
      render :edit
    end
  end

  # destroy
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to @song.artist
  end

  private
  def song_params
    params.require(:song).permit(:title, :album, :preview_url, :artist_id)
  end
end
