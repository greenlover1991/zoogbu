module AdminMainHelper
 def process_file_uploader
  #validates_file_format_of :img_upload, 
	#					   :in=>["gif", "jpg", "jpeg", "png", "bmp", "tif", "tiff","pcx", "tga", "svg", "ico"],
	#					   :message=>"Sorry. Invalid image file"

   if img_upload
     unless img_upload.class === "String"
	 dest = File.open("#{::Rails.root.to_s}/public/images/data/#{img_upload.original_filename}", 'wb')
	 dest.write(img_upload.read)
       self.img_url = "/images/data/#{img_upload.original_filename}" 
     end 
   end
  end
end
