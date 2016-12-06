include Log
require 'fileutils'

class LocalManager
  attr_accessor :files

  def initialize root_path, ignore_list
    @root = root_path
    @root += '/' if @root[-1] != '/'
    @ignore_list = ignore_list
    FileUtils.mkdir_p @root
  end

  def get_files
    @files = Dir[File.join(@root, '**', '*')].reject{|f| File.directory?(f)}
    @files = @files.collect{|file| file.sub @root, ''}
    @files = @files.reject{|f| @ignore_list.include? f}
  end

  #For consistency's sake..
  #Returns the path if file exists, nil otherwise
  def find_by_path path
    return nil if @files == nil
    @files.select{|file| file == path}.first
  end
end