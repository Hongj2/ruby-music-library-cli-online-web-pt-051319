class Song
extend Concerns::Findable
attr_accessor :name
attr_reader :artist, :genre
@@all=[]
  
  def initialize(name,artist=nil,genre=nil)
    @name=name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
   
  def self.all 
    @@all 
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    self.class.all << self
  end
  
  def self.create (name)
    song = Song.new(name)
    song.save
    song
  end


def artist=(artist)
  @artist= artist
  artist.add_song(self)
end

def genre=(genre)
  @genre= genre
  genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(name)
  @@all.detect{|song|song.name == name}
end

 def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)

   end
  
  def self.new_from_filename(filename)
    artist_name, song_name, genre= filename.split(' - ')
    genre = genre.split('.mp3')[0]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre)
    song = self.new(song_name,artist,genre)
 song
  end
    
    def self.create_from_filename(name)
      song = new_from_filename(name)
      song.save
      song
    end
      
    
  
end 

  