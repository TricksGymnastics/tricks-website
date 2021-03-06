# encoding: utf-8

class CoachImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def fog_directory
    'coach-pics'
  end
  
  # https://stackoverflow.com/questions/15823061/how-can-i-reorganize-an-existing-folder-hierarchy-with-carrierwave
  def store_dir
    "uploads/#{model.firstname+'_'+model.lastname}".tr(" ", "_")
  end

  def default_url
    "neutral_default.png"
    # if model.gender == "Girl" || model.gender == "girl" then
    #   "girl_default.jpg"
    # else
    #   "boy_default.jpg"
    # end
  end

  # def auto_orient
  #   manipulate! do |img|
  #     img = img.auto_orient
  #   end
  # end
  process :rotate_according_to_exif

  def rotate_according_to_exif
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  version :thumb do
    # process :auto_orient
    process :rotate_according_to_exif
    process :resize_to_fill => [210, 290]
  end

  version :small_thumb, :from_version => :thumb do 
    # process :auto_orient
    process :rotate_according_to_exif
    process :resize_to_limit => [150, 150]
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def filename
  #   "#{model.firstname+'_'+model.lastname}.#{file.extension}".tr(" ", "_") if original_filename
  # end
end