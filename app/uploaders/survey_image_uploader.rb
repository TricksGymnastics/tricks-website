# encoding: utf-8

class SurveyImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def fog_directory
    'survey-result-images'
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end